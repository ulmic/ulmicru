class Delivery::Receiver < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user, polymorphic: true

  state_machine :state, initial: :added do
    state :added
    state :ready
    state :sent

    event :send_email do
      transition all => :sent
    end
  end

  include StateMachine::Scopes

end
