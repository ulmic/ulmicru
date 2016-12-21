class CreateActivityLinesLiderYaLiderStages < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_lider_stages do |t|
      t.integer :number
      t.integer :ya_lider_id
      t.text :title
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
