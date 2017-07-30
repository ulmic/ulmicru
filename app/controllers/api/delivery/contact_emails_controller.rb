class Api::Delivery::ContactEmailsController < Api::ApplicationController
  def create
    contact_email = ::Delivery::SubscribeContactEmailForm.new ::Delivery::ContactEmail.new
    params[:delivery_contact_email][:state] = :not_active
    if contact_email.validate(params[:delivery_contact_email]) && contact_email.save
      ContactEmailMailer.delay.create contact_email
      head :ok
    else
      head :bad_request
    end
  end
end
