class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_item
  has_many :notificatons, dependent: :destroy
end
