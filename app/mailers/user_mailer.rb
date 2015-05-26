class UserMailer < ApplicationMailer

  attr_accessor :message

  include Concerns::MessageConstructor

  def after_create(object, user)
    @user = user
    @message = create_message object.class.name.downcase, :after_create
    mail to: user.email
  end

  def just_message(user, message, subject)
    @user = user
    @message = message
    mail(to: user.email, subject: subject)
  end
end
