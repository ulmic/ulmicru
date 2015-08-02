class AddImageVersionsToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :horizontal, :text
    add_column :banners, :vertical, :text
  end
end
