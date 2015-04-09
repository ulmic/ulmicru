class AddLogoToActivityLine < ActiveRecord::Migration
  def change
    add_column :activity_lines, :logo, :text
  end
end
