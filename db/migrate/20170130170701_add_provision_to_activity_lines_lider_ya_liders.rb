class AddProvisionToActivityLinesLiderYaLiders < ActiveRecord::Migration
  def change
    add_column :activity_lines_lider_ya_liders, :provision, :text
  end
end
