class AddStateToNews < ActiveRecord::Migration
  def change
    add_column :news, :state, :text
  end
end
