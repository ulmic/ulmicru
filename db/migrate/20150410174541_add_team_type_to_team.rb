class AddTeamTypeToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :team_type, :text
  end
end
