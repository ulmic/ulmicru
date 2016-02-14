class DeliveryJob < ActiveJob::Base
  queue_as :default

  def perform(emails, title, text, link)
  end
end
