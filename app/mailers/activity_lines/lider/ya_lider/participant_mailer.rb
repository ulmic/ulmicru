class ActivityLines::Lider::YaLider::ParticipantMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def fail_api_create(participant, user)
    @user = user
    @subject = subject(participant.class, :fail_api_create)
    mail from: sender_name, to: user.corporate_email.present? ? user.corporate_email : user.email, subject: @subject
  end
end
