class AddPostItems < ActiveRecord::Migration[6.1]
  def change
    add_column :post_items, :lat, :float
    add_column :post_items, :lng, :float
  end
end
