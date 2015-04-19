class AddJoinDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :join_date, :datetime
  end
end
