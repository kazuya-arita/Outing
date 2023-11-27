class AddRepostItemIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :repost_item_id, :integer
  end
  
  # add_index :notifications, :repost_item_id
  
end
