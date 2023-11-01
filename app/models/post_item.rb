class PostItem < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :repost_items, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg' )
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #投稿内容の検索
  def self.search(search)
    if search
      PostItem.where(['post_item LIKE ? OR address LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      PostItem.all.order('created_at DESC').limit(50)
    end
  end

  def create_notification_favorite!(current_user)
    #すでにいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_item_id = ? and action = ? ", current_user.id, user_id, id, "favorite"])

    if temp.blank?
      notification = current_user.active_notifications.new(post_item_id: id, visited_id: user_id, action: "favorite")
      #自分が投稿したものに自分でいいねした場合は通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(post_item_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, user_id)
    #コメントは複数回することがあるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(post_item_id: id, post_comment_id: post_comment_id, visited_id: user_id, action: 'comment')
    #自分の投稿に自分でコメントする場合は通知済みにする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

   #非公開アカウントの投稿を表示させない
  def self.hide_nonreleased_post_items
    PostItem.joins(:user).where(user: { status: "released"}).order('created_at DESC')
  end



end
