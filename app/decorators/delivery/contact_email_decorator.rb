class Delivery::ContactEmailDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :subscribed_to_deliveries, :active ]
  end
end
