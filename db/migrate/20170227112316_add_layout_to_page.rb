class AddLayoutToPage < ActiveRecord::Migration
  def change
    add_column :pages, :layout, :text, default: :default
  end
end
