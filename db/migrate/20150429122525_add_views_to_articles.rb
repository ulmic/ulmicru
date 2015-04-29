class AddViewsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :views, :integer, default: 0
  end
end
