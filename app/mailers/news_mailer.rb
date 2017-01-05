class NewsMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def create(news, user)
    @user = user
    @news = news
    mail from: sender_name, to: user.corporate_email.present? ? user.corporate_email : user.email, subject: subject(news.class, :create)
  end
end
