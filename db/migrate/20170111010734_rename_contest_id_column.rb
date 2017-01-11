class RenameContestIdColumn < ActiveRecord::Migration
  def change
    rename_column :activity_lines_lider_ya_lider_participants, :contest_year, :contest_id
  end
end
