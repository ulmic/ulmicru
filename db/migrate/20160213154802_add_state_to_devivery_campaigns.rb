class AddStateToDeviveryCampaigns < ActiveRecord::Migration
  def change
    add_column :delivery_campaigns, :state, :text
  end
end
