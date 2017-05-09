class Api::Users::Account::SubscriptionsController < Api::Users::ApplicationController
  def create
    subscription = SubscriptionForm.new_with_model
    params[:subscription][:receiver_id] = current_user.id
    params[:subscription][:receiver_type] = 'User'
    if subscription.submit params[:subscription]
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    subscription = current_user.subscriptions.find_by subscription_type: params[:subscription][:subscription_type]
    subscription.destroy
    head :ok
  end
end
