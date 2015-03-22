class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :main_photo
      t.integer :creator_id
      t.datetime :begin_date
      t.datetime :end_date
      t.string :event_type

      t.timestamps null: false
    end
  end
end
