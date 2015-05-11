class AddActivityLineIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :activity_line_id, :integer
  end
end
