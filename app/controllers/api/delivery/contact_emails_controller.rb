class Api::Delivery::ContactEmailsController < Api::ApplicationController
  def create
    contact_email = ::Delivery::SubscribeContactEmailForm.new ::Delivery::ContactEmail.new
    if contact_email.validate params[:delivery_contact_email]
      contact_email.save
      head :ok
    else
      head :bad_request
    end
  end
end
