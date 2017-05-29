class Web::Admin::Delivery::SessionsController < Web::Admin::Delivery::ApplicationController
  def create
    campaign = ::Delivery::Campaign.find(params[:id]).decorate
    campaign.receivers.update_all state: :ready
    campaign.start_mailing
    redirect_to admin_delivery_campaign_path campaign
  end

  def destroy
  end
end
