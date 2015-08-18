class AddStateToTags < ActiveRecord::Migration
  def change
    add_column :tags, :state, :text
  end
end
