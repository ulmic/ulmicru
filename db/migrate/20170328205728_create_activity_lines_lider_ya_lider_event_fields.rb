class CreateActivityLinesLiderYaLiderEventFields < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_lider_event_fields do |t|
      t.text :field_type
      t.text :value
      t.integer :event_id
      t.text :title

      t.timestamps null: false
    end
  end
end
