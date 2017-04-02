class RenameTableToParticipantEvents < ActiveRecord::Migration
  def change
    rename_table :activity_lines_lider_ya_lider_events, :activity_lines_lider_ya_lider_participant_events
  end
end
