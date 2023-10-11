class PostItem < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
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
  
  def self.search(search)
    if search
      PostItem.where(['post_item LIKE ? OR address LIKE(?)', "%#{search}%", "%#{search}%"])
      
    else
      PostItem.all.order('created_at DESC').limit(50)
    end
  end
  
end
