class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.string :email, null: false, default: ""

      t.timestamps
    end
  end
end
