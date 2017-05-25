class AddMoreFieldsToProtocols < ActiveRecord::Migration
  def change
    add_column :protocols, :summons, :text
    add_column :protocols, :begin_date, :datetime
    add_column :protocols, :end_date, :datetime
  end
end
