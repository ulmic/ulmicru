class AddMainPositionTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :main_position_title, :text
  end
end
