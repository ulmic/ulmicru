class Web::Admin::Delivery::SessionsController < Web::Admin::Delivery::ApplicationController
  def create
    campaign = ::Delivery::Campaign.find(params[:id]).decorate
    ::DeliveryJob.perform_later campaign.contacts, campaign.title, campaign.body, campaign.link, campaign.image.url
  end

  def destroy
  end
end
