class ActivityLines::Corporative::OnlineConference::QuestionMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def confirm(question, user)
    @user = user
    @question = question
    @subject = subject(question.class, :confirm)
    mail from: sender_name, to: user.corporate_email.present? ? user.corporate_email : user.email, subject: @subject
  end

  def answer(question, user)
    @user = user
    @question = question
    @subject = subject(question.class, :answer)
    mail from: sender_name, to: user.corporate_email.present? ? user.corporate_email : user.email, subject: @subject
  end

  def text_update(question, user)
    @user = user
    @question = question
    @logged_actions = question.logged_actions
    @subject = subject(question.class, :text_update)
    mail from: sender_name, to: user.corporate_email.present? ? user.corporate_email : user.email, subject: @subject
  end
end
