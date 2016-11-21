class FeedbackMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def finish(feedback, user)
    @user = user
    @feedback = feedback.decorate
    @subject = subject(feedback.class, :finish)
    mail from: sender_name, to: user.email, subject: @subject
  end
end
