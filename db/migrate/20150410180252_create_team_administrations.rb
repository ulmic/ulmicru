class CreateTeamAdministrations < ActiveRecord::Migration
  def change
    create_table :team_administrations do |t|

      t.timestamps null: false
    end
  end
end
