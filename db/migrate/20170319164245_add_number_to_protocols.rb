class AddNumberToProtocols < ActiveRecord::Migration
  def change
    add_column :protocols, :number, :integer
  end
end
