class AddStateToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :state, :text
  end
end
