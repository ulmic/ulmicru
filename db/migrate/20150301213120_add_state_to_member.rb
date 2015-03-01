class AddStateToMember < ActiveRecord::Migration
  def change
    add_column :members, :state, :text
  end
end
