class CreateActivityLines < ActiveRecord::Migration
  def change
    create_table :activity_lines do |t|
      t.string :title
      t.datetime :found_date
      t.string :type
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
