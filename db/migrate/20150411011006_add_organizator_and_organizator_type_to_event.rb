class AddOrganizatorAndOrganizatorTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :organizer_id, :integer
    add_column :events, :organizer_type, :text
  end
end
