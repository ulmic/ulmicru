class AddPublicityToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publicity, :text
  end
end
