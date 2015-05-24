class UserMailer < ApplicationMailer
  def confirmation_instructions(user)
    @user = user
    mail(to: user.email)
  end

  def remind_password(user)
    @user = user
    mail(to: user.email)
  end

  def just_message(user, message, subject)
    @user = user
    @message = message
    mail(to: user.email, subject: subject)
  end

  def activation_info(user)
    @user = user
    mail to: user.email
  end

  def fair_idea_confirmation(user)
    @user = user
    mail to: user.email, subject: I18n.t('mailers.fair_idea_confirmation.subject')
  end
end
