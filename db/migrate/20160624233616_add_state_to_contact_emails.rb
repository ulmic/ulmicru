class AddStateToContactEmails < ActiveRecord::Migration
  def change
    add_column :delivery_contact_emails, :state, :text, default: :active
  end
end
