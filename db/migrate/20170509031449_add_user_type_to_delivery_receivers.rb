class AddUserTypeToDeliveryReceivers < ActiveRecord::Migration
  def change
    add_column :delivery_receivers, :user_type, :text
  end
end
