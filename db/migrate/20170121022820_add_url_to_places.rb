class AddUrlToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :url, :text
  end
end
