class CreateActivityLinesCorporativeConfessions < ActiveRecord::Migration
  def change
    create_table :activity_lines_corporative_confessions do |t|
      t.integer :year
      t.integer :member_id
      t.text :nomination
      t.text :state

      t.timestamps null: false
    end
  end
end
