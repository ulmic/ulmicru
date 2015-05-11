class AddStateToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :state, :text
  end
end
