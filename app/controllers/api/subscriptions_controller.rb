class Api::SubscriptionsController < Api::ApplicationController
  def destroy
    subscription = Token.subscriptions.where(content: params[:token]).first&.record
    if subscription.present?
      subscription.destroy
      head :ok
    else
      head :bad_request
    end
  end
end
