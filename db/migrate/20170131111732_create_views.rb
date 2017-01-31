class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :record_id
      t.text :record_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
