class AddProjectIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :project_id, :integer
    add_column :teams, :project_type, :text
  end
end
