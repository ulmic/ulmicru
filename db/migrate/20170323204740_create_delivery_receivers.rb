class CreateDeliveryReceivers < ActiveRecord::Migration
  def change
    create_table :delivery_receivers do |t|
      t.integer :user_id
      t.integer :campaign_id
      t.text :state

      t.timestamps null: false
    end
  end
end
