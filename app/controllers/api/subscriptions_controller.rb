class Api::SubscriptionsController < Api::ApplicationController
  def destroy
    subscription = Subscription.joins(:token).where('token.content = ?', params[:token]).first
    if subscription.present?
      subscription.destroy
      head :ok
    else
      head :bad_request
    end
  end
end
