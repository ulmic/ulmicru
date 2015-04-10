class AddMunicipalityToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :municipality, :text
    remove_column :teams, :team_type
    add_column :teams, :type, :text
  end
end
