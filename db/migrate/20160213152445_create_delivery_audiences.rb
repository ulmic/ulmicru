class CreateDeliveryAudiences < ActiveRecord::Migration
  def change
    create_table :delivery_audiences do |t|
      t.text :audience_type
      t.integer :audience_id

      t.timestamps null: false
    end
  end
end
