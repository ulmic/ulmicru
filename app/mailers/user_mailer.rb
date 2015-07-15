class UserMailer < ApplicationMailer

  attr_accessor :image_src

  include Concerns::MessageConstructor

  default template_path: "mailers/#{self.name.underscore}"

  def confirmation_instructions(user_model)
    @user = user_model
    mail to: user_model.email
  end

  def after_create(object, user)
    @user = user
    @image_src = "http://ul-lider.ru/confirmation_idea_fair.jpg"
    mail to: @user.email, subject: subject(object.class, :after_create)
  end

  def just_message(user, message, subject)
    @user = user
    @message = message
    mail(to: user.email, subject: subject)
  end

end
