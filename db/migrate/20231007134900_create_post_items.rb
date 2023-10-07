class CreatePostItems < ActiveRecord::Migration[6.1]
  def change
    create_table :post_items do |t|

      t.integer :user_id, null: false
      t.text :post_item, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
