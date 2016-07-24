class QuestionaryMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(news, user)
    @user = user
    @questionary = questionary
    mail from: sender_name, to: user.email, subject: subject(questionary.class, :create)
  end
end
