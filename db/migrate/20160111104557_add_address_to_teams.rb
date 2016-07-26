class AddAddressToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :address, :string
  end
end
