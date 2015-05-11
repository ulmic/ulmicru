class EditCreatorIdToHeadIdInActivityLines < ActiveRecord::Migration
  def change
    rename_column :activity_lines, :creator_id, :member_id
  end
end
