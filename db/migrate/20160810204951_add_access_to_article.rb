class AddAccessToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :access, :text, default: :all
  end
end
