class RenameEventsYaLiderAssociationColumn < ActiveRecord::Migration
  def change
    rename_column :activity_lines_lider_events_ya_liders, :activity_lines_lider_ya_lider_id, :ya_lider_id
  end
end
