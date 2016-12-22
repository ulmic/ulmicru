class AddStateToActivityLinesLiderYaLiderStages < ActiveRecord::Migration
  def change
    add_column :activity_lines_lider_ya_lider_stages, :state, :text
  end
end
