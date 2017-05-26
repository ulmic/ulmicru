class RemoveTitleFromProtocols < ActiveRecord::Migration
  def change
    remove_column :protocols, :title, :string
  end
end
