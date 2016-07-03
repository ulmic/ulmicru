class Web::SubscriptionsController < Web::ApplicationController
  def destroy
    subscription = Token.subscriptions.where(content: params[:token]).first&.record
    if subscription.present?
      subscription.destroy
      @page = Page.find_by_slug :unsubscribe_successful
      render 'web/pages/show'
    else
      @page = Page.find_by_slug :server_error
      render 'web/pages/show', status: :bad_request
    end
  end
end
