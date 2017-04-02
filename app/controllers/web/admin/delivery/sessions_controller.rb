class Web::Admin::Delivery::SessionsController < Web::Admin::Delivery::ApplicationController
  def create
    campaign = ::Delivery::Campaign.find(params[:id]).decorate
    contacts = campaign.receivers.includes(:user).where(state: :ready).to_a
    subscriptions = Subscription.where(subscription_type: :deliveries, receiver_id: contacts.map(&:user_id), receiver_type: 'User')
    hash_sub = subscriptions.reduce({}) do |hash, sub|
      hash.merge! sub.id.to_s => sub.receiver_id 
    end
    tokens = Token.where(record_type: 'Subscription', record_id: subscriptions.map(&:id))
    hash_tokens = tokens.reduce({}) do |hash, token|
      hash.merge! hash_sub[token.record_id.to_s].to_s => token.content
    end
    ::DeliveryJob.perform_later contacts, campaign.title, campaign.body, campaign.link, campaign.image.url, hash_tokens
    campaign.start_mailing
    redirect_to sidekiq_web_path
  end

  def destroy
  end
end
