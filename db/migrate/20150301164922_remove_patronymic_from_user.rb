class RemovePatronymicFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :patronymic
  end
end
