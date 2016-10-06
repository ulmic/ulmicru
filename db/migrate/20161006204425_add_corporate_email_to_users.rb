class AddCorporateEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :corporate_email, :text
  end
end
