class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_item
  has_many :notifications, dependent: :destroy
end
