class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:user_name]

  has_many :post_items, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォローしたユーザーとの関係
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォローされたユーザーとの関係
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :repost_items, dependent: :destroy

  has_many :active_notifications, class_name: "Notofications", foreign_key: "visitor_id", dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: "Notofications", foreign_key: "visited_id", dependent: :destroy #相手からの通知

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  #ユーザーの検索
  def self.search(search)
    if search
      User.where(['nickname LIKE ? OR user_name LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      User.all.limit(50)
    end
  end

  #リポストしているか判定
  def repost_item?(post_item_id)
    self.repost_items.where(post_item_id: post_item_id).exists?
  end

  #リポストした投稿を取得するメソッド
  def post_items_with_repost_items
    relation = PostItem.joins("LEFT OUTER JOIN repost_items ON post_items.id = repost_items.post_item_id")
                       .joins("LEFT OUTER JOIN users ON repost_items.user_id = users.id")
                       .select("post_items.*, repost_items.user_id AS repost_item_user_id, users.nickname AS repost_item_user_nickname")

    relation.where(user_id: self.id)
            .or(relation.where("repost_items.user_id = ?", self.id))
            .with_attached_image
            .preload(:user, :post_comments, :favorites, :repost_items)
            .order(Arel.sql("CASE WHEN repost_items.created_at IS NULL THEN post_items.created_at ELSE repost_items.created_at END"))
  end
  
  #フォローしている人がリポストした投稿を取得するメソッド
  def followings_post_items_with_repost_items
    relation = PostItem.joins("LEFT OUTER JOIN post_items.id = repost_items.post_item_id AND (repost_items.user_id = #{self.id} OR repost_items.user_id IN (SELECT follower_id FROM relationships WHERE user_id = #{self.id}))")
                       .select()
                       
    relation                   
  end

  #フォロー時の通知の処理
  def create_notification_follow!(current_user)
    temp = Notofication.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
      notification.save if notification.valid?
    end
  end

  validates :user_name,
  uniqueness: true,
  length: {maximum: 10 },
  format: { with: /\A@[a-z0-9]+\z/, message: 'は@を先頭に小文字英数字で入力してください。' }

end
