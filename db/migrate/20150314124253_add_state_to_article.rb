class AddStateToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :state, :text
  end
end
