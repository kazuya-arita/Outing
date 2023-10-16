class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false #フォローしたユーザー
      t.integer :followed_id, null: false #フォローされたユーザー
     
      t.timestamps
    end
  end
end
