class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :receiver_id
      t.integer :receiver_type
      t.text :subscription_type

      t.timestamps null: false
    end
  end
end
