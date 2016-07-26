class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = configus.host
  default from: "#{configus.host} <#{configus.mailer.from}>", content_transfer_encoding: '7bit'
  default template_path: 'mailers'

  include Concerns::MessageConstructor

  protected

  def sender_name
    "#{I18n.t('organization.title')} <#{configus.mailer.from}>"
  end
end
