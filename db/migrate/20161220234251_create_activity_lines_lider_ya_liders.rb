class CreateActivityLinesLiderYaLiders < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_liders do |t|
      t.integer :contest_number
      t.integer :contest_year
      t.text :state

      t.timestamps null: false
    end
  end
end
