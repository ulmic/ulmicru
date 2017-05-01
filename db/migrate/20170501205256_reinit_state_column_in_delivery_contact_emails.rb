class ReinitStateColumnInDeliveryContactEmails < ActiveRecord::Migration
  def change
    remove_column :delivery_contact_emails, :state
    add_column :delivery_contact_emails, :state, :text, default: :active
  end
end
