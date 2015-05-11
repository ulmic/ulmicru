class CreateEventRegistrations < ActiveRecord::Migration
  def change
    create_table :event_registrations do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :role

      t.timestamps null: false
    end
  end
end
