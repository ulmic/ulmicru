class AddStateToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :state, :text
  end
end
