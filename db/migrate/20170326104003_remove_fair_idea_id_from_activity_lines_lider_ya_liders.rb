class RemoveFairIdeaIdFromActivityLinesLiderYaLiders < ActiveRecord::Migration
  def change
    remove_column :activity_lines_lider_ya_liders, :fair_idea_id
  end
end
