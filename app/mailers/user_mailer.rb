class UserMailer < ApplicationMailer

  attr_accessor :image_src

  include Concerns::MessageConstructor

  default template_path: "mailers/#{self.name.underscore}"

  def after_create(object, user)
    @user = user
    @image_src = src_with_host '/logo.png'
    mail from: sender_name, to: @user.email, subject: subject(object.class, :after_create)
  end

  def remind_password(object, user)
    @user = user
    @image_src = src_with_host '/logo.png'
    mail from: sender_name, to: @user.email, subject: subject(object.class, :remind_password)
  end

  def just_message(user, subject, message, link = nil, image = nil)
    @user = user
    @message = message
    @link = link
    @image = src_with_host image
    @subscription_token = subscription_token
    mail from: sender_name, to: user.email, subject: subject
  end

  private

  def src_with_host(src)
    "#{configus.full_host}#{src}"
  end

  def sender_name
    "#{I18n.t('organization.title')} <#{configus.mailer.from}>"
  end
end
