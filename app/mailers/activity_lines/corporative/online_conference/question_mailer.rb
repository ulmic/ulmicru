class ActivityLines::Corporative::OnlineConference::QuestionMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def confirm(question, user)
    @user = user
    @question = question
    @subject = subject(question.class, :confirm)
    mail from: sender_name, to: user.email, subject: @subject
  end

  def answer(question, user)
    @user = user
    @question = question
    @subject = subject(question.class, :answer)
    mail from: sender_name, to: user.email, subject: @subject
  end

  def text_update(question, user)
    @user = user
    @question = question
    @logged_actions = question.logged_actions.include(:user)
    @subject = subject(question.class, :text_update)
    mail from: sender_name, to: user.email, subject: @subject
  end
end
