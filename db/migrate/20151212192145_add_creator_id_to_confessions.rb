class AddCreatorIdToConfessions < ActiveRecord::Migration
  def change
    add_column :activity_lines_corporative_confessions, :creator_id, :integer
  end
end
