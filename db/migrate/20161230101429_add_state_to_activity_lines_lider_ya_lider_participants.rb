class AddStateToActivityLinesLiderYaLiderParticipants < ActiveRecord::Migration
  def change
    add_column :activity_lines_lider_ya_lider_participations, :state, :text
  end
end
