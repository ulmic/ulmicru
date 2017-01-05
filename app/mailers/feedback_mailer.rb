class FeedbackMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def finish(feedback, user)
    @user = user
    @feedback = feedback.decorate
    @subject = subject(feedback.class, :finish)
    mail from: sender_name, to: user.notificable_email, subject: @subject
  end
end
