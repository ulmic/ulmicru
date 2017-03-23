class Web::Admin::Delivery::SessionsController < Web::Admin::Delivery::ApplicationController
  def create
    campaign = ::Delivery::Campaign.find(params[:id]).decorate
    campaign.contacts.each_slice(100) do |combination|
      ::DeliveryJob.perform_later combination, campaign.title, campaign.body, campaign.link, campaign.image.url
    end
    #campaign.start_mailing
    redirect_to sidekiq_web_path
  end

  def destroy
  end
end
