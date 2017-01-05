class QuestionaryMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(questionary, user)
    @user = user
    @questionary = questionary
    mail from: sender_name, to: user.corporate_email.present? ? user.corporate_email : user.email, subject: subject(questionary.class, :create, :admin)
  end
end
