class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :text
  end
end
