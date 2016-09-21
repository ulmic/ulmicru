class AddStatusToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :status, :text, default: :confirmed
  end
end
