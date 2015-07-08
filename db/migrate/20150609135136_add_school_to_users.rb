class AddSchoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school, :text
  end
end
