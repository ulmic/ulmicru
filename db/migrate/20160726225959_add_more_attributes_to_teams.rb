class AddMoreAttributesToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :founding_date, :datetime
    add_column :teams, :vkontakte, :text
    add_column :teams, :twitter, :text
    add_column :teams, :instagram, :text
  end
end
