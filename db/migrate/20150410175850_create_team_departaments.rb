class CreateTeamDepartaments < ActiveRecord::Migration
  def change
    create_table :team_departaments do |t|

      t.timestamps null: false
    end
  end
end
