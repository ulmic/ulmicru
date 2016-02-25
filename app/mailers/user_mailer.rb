class UserMailer < ApplicationMailer

  attr_accessor :image_src

  include Concerns::MessageConstructor

  default template_path: "mailers/#{self.name.underscore}"

  def after_create(object, user)
    @user = user
    @image_src = '/logo.png'
    mail to: @user.email, subject: subject(object.class, :after_create)
  end

  def remind_password(object, user)
    @user = user
    @image_src = '/logo.png'
    mail to: @user.email, subject: subject(object.class, :remind_password)
  end

  def just_message(user, subject, message, link = nil, image = nil)
    @user = user
    @message = message
    @link = link
    @image = image
    mail to: user.email, subject: subject
  end
end
