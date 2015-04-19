class AddViewsToNews < ActiveRecord::Migration
  def change
    add_column :news, :views, :integer, default: 0
  end
end
