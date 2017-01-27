class AddStateToActivityLinesCorporativeMerits < ActiveRecord::Migration
  def change
    add_column :activity_lines_corporative_merits, :state, :text
  end
end
