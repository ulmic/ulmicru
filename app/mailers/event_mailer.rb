class EventMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def update(event, user)
    @user = user
    @event = event
    mail from: sender_name, to: user.email, subject: subject(event.class, :update)
  end
end
