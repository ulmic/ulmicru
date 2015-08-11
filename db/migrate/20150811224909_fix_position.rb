class FixPosition < ActiveRecord::Migration
  def change
    remove_column :positions, :end_date
    add_column :positions, :end_date, :datetime
    add_column :positions, :for_now, :text
  end
end
