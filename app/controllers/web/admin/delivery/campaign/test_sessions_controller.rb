class Web::Admin::Delivery::Campaign::TestSessionsController < Web::Admin::Delivery::ApplicationController
  def create
    campaign = ::Delivery::Campaign.find(params[:id]).decorate
    contacts = campaign.receivers.includes(user: :subscriptions).where(state: :ready).to_a
    ::Admin::TestReceiversJob.perform_later contacts, campaign.title, campaign.body, campaign.link, campaign.image.url, campaign.id
    redirect_to admin_delivery_campaign_path(campaign.id)
  end
end
