class DeliveryJob < ActiveJob::Base
  queue_as :default

  def perform(emails, title, text, link, image)
    user = Struct.new email: contact.email, first_name: contact.first_name, last_name: contact.last_name 
    emails.each do |email|
      UserMailer.delay.send(user, title, text, link, image)
    end
  end
end
