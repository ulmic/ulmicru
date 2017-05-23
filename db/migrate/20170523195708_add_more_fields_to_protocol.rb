class AddMoreFieldsToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :invited, :text
  end
end
