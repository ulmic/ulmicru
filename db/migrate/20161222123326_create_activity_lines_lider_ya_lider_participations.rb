class CreateActivityLinesLiderYaLiderParticipations < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_lider_participations do |t|
      t.integer :participant_id
      t.integer :stage_id

      t.timestamps null: false
    end
  end
end
