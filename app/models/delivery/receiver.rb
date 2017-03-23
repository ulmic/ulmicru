class Delivery::Receiver < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  state_machine :state, initial: :ready do
    state :ready
    state :sent

    event :send_email do
      transition all => :sent
    end
  end
end
