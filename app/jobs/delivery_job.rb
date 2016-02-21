class DeliveryJob < ActiveJob::Base
  queue_as :default

  def perform(contacts, title, text, link, image)
    contacts.each do |contact|
      UserMailer.delay.send contact, title, text, link, image
    end
  end
end
