class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :difference
      t.integer :user_id
      t.integer :target_id
      t.text :target_type

      t.timestamps null: false
    end
  end
end
