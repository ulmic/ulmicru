class AddTeamsMembersTable < ActiveRecord::Migration
  def change
    create_table :teams_members, id: false do |t|
      t.belongs_to :team, index: true
      t.belongs_to :member, index: true
    end
  end
end
