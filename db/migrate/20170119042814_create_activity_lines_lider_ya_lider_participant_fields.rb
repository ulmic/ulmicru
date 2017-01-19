class CreateActivityLinesLiderYaLiderParticipantFields < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_lider_participant_fields do |t|
      t.integer :participant_id
      t.text :title
      t.text :value

      t.timestamps null: false
    end
  end
end
