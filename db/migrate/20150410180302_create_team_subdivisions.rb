class CreateTeamSubdivisions < ActiveRecord::Migration
  def change
    create_table :team_subdivisions do |t|

      t.timestamps null: false
    end
  end
end
