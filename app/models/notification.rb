class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post_item, optional: true
  belongs_to :post_comment, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true #自分からの通知
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true #相手からの通知

  belongs_to :warning, class_name: "Admin", foreign_key: "visitor_id", optional: true #運営からの警告通知

end
