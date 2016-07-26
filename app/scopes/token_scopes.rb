require 'scopes_rails/state_machine/scopes'

module TokenScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :subscriptions, -> { where record_type: 'Subscription' }
  end
end
