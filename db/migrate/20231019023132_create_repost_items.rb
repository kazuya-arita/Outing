class CreateRepostItems < ActiveRecord::Migration[6.1]
  def change
    create_table :repost_items do |t|
      t.references :user, foreign_key: true
      t.references :post_item, foreign_key: true
      t.timestamps
    end
  end
end
