class CreateDeliveryContactEmails < ActiveRecord::Migration
  def change
    create_table :delivery_contact_emails do |t|
      t.text :email
      t.text :first_name
      t.text :last_name

      t.timestamps null: false
    end
  end
end
