class AddStateToActivityLinesLiderYaLiderParticipants < ActiveRecord::Migration
  def change
    add_column :activity_lines_lider_ya_lider_participants, :state, :text
  end
end
