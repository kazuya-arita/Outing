class RepostItem < ApplicationRecord
  belongs_to :user
  belongs_to :post_item
end
