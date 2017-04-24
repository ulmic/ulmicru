class AddEmailStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_state, :text, default: :active
  end
end
