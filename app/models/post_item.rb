class PostItem < ApplicationRecord
  belongs_to :user
  
  has_one_attached :image
  
  def get_image(width, height)
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
