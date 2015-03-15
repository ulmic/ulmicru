class AddIsLastToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :is_last, :boolean
  end
end
