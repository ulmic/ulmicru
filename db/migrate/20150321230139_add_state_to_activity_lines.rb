class AddStateToActivityLines < ActiveRecord::Migration
  def change
    add_column :activity_lines, :state, :string
  end
end
