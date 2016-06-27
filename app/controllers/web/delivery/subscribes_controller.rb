class Web::Delivery::SubscribesController < Web::Delivery::ApplicationController
  def destroy
    @contact_email = ContactEmail.find params[:email]
    if @contact_email&.subscribe_token.content == params[:token]
      @contact_email.unsubscribe
    end
  end
end
