class AddStateToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :state, :text
  end
end
