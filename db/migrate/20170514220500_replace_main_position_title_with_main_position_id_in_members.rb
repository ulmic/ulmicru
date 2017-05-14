class ReplaceMainPositionTitleWithMainPositionIdInMembers < ActiveRecord::Migration
  def change
    remove_column :users, :main_position_title
    add_column :users, :main_position_id, :integer
  end
end
