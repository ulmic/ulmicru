class CreateLoggedActions < ActiveRecord::Migration
  def change
    create_table :logged_actions do |t|
      t.integer :user_id
      t.text :action_type
      t.text :record_type
      t.integer :record_id
      t.text :params

      t.timestamps null: false
    end
  end
end
