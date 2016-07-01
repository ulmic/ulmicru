class Web::Admin::Delivery::SessionsController < Web::Admin::Delivery::ApplicationController
  def create
    campaign = ::Delivery::Campaign.find(params[:id]).decorate
    ::DeliveryJob.perform_later campaign.contacts.include(subscriptions: :token), campaign.title, campaign.body, campaign.link, campaign.image.url
    campaign.start_mailing
    redirect_to sidekiq_web_path
  end

  def destroy
  end
end
