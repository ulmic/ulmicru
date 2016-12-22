class CreateActivityLinesLiderYaLiderParticipants < ActiveRecord::Migration
  def change
    create_table :activity_lines_lider_ya_lider_participants do |t|
      t.integer :contest_year
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
