class CreateDeliveryCampaignTests < ActiveRecord::Migration
  def change
    create_table :delivery_campaign_tests do |t|
      t.integer :campaign_id
      t.integer :receiver_id
      t.text :result

      t.timestamps null: false
    end
  end
end
