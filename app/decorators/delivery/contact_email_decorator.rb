class Delivery::ContactEmailDecorator < ApplicationDecorator
  delegate_all

  def short_name
    "#{first_name} #{last_name}"
  end

  def self.collections
    [ :subscribed_to_deliveries, :active ]
  end

  alias name short_name
end
