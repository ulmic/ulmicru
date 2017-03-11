class AddActivityLinesLiderYaLiders < ActiveRecord::Migration
  def change
    add_column :activity_lines_lider_ya_liders, :fair_idea_id, :integer
  end
end
