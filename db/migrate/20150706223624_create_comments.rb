class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :record_id
      t.text :record_type
      t.integer :user_id
      t.integer :parent_id
      t.text :state

      t.timestamps null: false
    end
  end
end
