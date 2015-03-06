class CreateQuestionaries < ActiveRecord::Migration
  def change
    create_table :questionaries do |t|
      t.text :experience
      t.text :want_to_do
      t.integer :member_id

      t.timestamps null: false
    end
  end
end
