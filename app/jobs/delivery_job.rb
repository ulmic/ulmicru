class DeliveryJob < ActiveJob::Base
  queue_as :default

  def perform(contacts, title, text, link, image, tokens)
    contacts.each_slice(100) do |combination|
      combination.each do |contact|
        UserMailer.delay.send :just_message, contact.user.decorate, contact.user.email, title, text, link, image, tokens[contact.user_id.to_s]
        contact.send_email
      end
    end
  end
end
