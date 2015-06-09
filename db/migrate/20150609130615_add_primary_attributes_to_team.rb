class AddPrimaryAttributesToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :school, :text
    add_column :teams, :team_id, :integer
  end
end
