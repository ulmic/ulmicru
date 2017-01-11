class RenameActivityLinesLiderYaLiderStageColumn < ActiveRecord::Migration
  def change
    rename_column :activity_lines_lider_ya_lider_stages, :ya_lider_id, :contest_id
  end
end
