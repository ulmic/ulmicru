class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :title
      t.integer :user_id
      t.string :description

      t.timestamps null: false
    end
  end
end
