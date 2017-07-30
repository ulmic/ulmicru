class ContactEmailMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(contact_email)
    @user = contact_email
    @contact_email = contact_email
    @subscription_token = contact_email.subscribe_token
    mail from: sender_name, to: user.email, subject: subject(contact_email.class, :create)
  end
end
