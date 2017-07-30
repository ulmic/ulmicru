class Web::Delivery::ContactEmailsController < Web::ApplicationController
  def update
    contact_email = Token.where(content: params[:token]).first.record
    contact_email.confirm
    redirect_to page_page_path :email_confirmed
  end
end
