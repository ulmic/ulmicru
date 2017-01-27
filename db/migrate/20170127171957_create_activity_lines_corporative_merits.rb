class CreateActivityLinesCorporativeMerits < ActiveRecord::Migration
  def change
    create_table :activity_lines_corporative_merits do |t|
      t.integer :user_id
      t.text :nomination
      t.integer :year

      t.timestamps null: false
    end
  end
end
