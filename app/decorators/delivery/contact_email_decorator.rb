class Delivery::ContactEmailDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [ :subscribed, :unsubscribed ]
  end
end
