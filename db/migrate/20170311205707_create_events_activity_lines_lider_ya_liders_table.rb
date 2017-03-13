class CreateEventsActivityLinesLiderYaLidersTable < ActiveRecord::Migration
  def change
    create_table :events_activity_lines_lider_ya_liders_tables do |t|
      t.integer :event_id
      t.integer :activity_lines_lider_ya_lider_id
      t.text :association_type
    end
  end
end
