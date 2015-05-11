class AddPlaceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :place, :text
  end
end
