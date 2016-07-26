class AddOrganizationTypeToActivityLine < ActiveRecord::Migration
  def change
    add_column :activity_lines, :organization_type, :text
  end
end
