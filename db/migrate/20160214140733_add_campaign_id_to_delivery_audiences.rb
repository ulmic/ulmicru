class AddCampaignIdToDeliveryAudiences < ActiveRecord::Migration
  def change
    add_column :delivery_audiences, :campaign_id, :integer
  end
end
