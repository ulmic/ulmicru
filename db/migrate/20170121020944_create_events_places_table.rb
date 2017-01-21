class CreateEventsPlacesTable < ActiveRecord::Migration
  def change
    create_table :events_places do |t|
      t.integer :event_id
      t.integer :place_id
    end
  end
end
