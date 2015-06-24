class AddMemberStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member_state, :text, default: :unviewed
  end
end
