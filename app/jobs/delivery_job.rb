class DeliveryJob < ActiveJob::Base
  queue_as :default

  def perform(contacts, title, text, link, image)
    contacts.each_slice(100) do |combination|
      combination.each do |contact|
        UserMailer.delay.send :just_message, contact, title, text, link, image, contact.subscribe_token.content
      end
      sleep 2
    end
  end
end
