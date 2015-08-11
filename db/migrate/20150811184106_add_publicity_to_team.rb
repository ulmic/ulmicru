class AddPublicityToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :publicity, :text
  end
end
