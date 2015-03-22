class CreateActivityLines < ActiveRecord::Migration
  def change
    create_table :activity_lines do |t|
      t.string :title
      t.datetime :found_date
      t.string :activity_type
      t.string :description
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
