class Web::Admin::Delivery::ContactEmailsController < Web::Admin::Delivery::ApplicationController
  skip_after_action :log_action

  def index
    if params[:search]
      contact_emails = Delivery::ContactEmail.presented.search params[:search]
    else 
      contact_emails = Delivery::ContactEmail.send params[:scope]
    end
    @contact_emails = contact_emails.page(params[:page]).decorate
  end

  def create
    collection = ::XlsParser.first_sheet_collection params[:file]
    collection.each do |item|
      Delivery::ContactEmail.create first_name: item[0], last_name: item[1], email: item[2]
    end
    redirect_to admin_delivery_contact_emails_path
  end

  def update
    @contact_email_form = Delivery::ContactEmailForm.find_with_model params[:id]
    @contact_email_form.submit params[:contact_email]
    if @contact_email_form.save
      redirect_to admin_contact_emails_path
    else
      render action: :edit
    end
  end

  def destroy
    @contact_email = Delivery::ContactEmail.find params[:id]
    @contact_email.remove
    redirect_to admin_contact_emails_path
  end
end
