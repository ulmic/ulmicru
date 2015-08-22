class AddStateToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :state, :text
  end
end
