class CreateActivityLinesLiderEventsYaLiders < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_events_ya_liders do |t|
      t.integer :event_id
      t.integer :activity_lines_lider_ya_lider_id
      t.text :association_type

      t.timestamps null: false
    end
  end
end
