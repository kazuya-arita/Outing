class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_item_id
      t.integer :post_comment_id
      t.string :action, deault: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_item_id
    add_index :notifications, :post_comment_id
    
  end
end
