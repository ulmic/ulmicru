class CreateActivityLinesLiderYaLiderEvents < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_lider_events do |t|
      t.integer :participant_id
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
