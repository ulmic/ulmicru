class RenameUserIdToMemberIdInTemas < ActiveRecord::Migration
  def change
    rename_column :teams, :user_id, :member_id
  end
end
