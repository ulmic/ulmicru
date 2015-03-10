class AddLeadToNews < ActiveRecord::Migration
  def change
    add_column :news, :lead, :text
  end
end
