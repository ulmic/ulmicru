class RemoveLocationFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :location, :string
  end
end
