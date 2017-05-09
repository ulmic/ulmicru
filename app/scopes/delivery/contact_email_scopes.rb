require 'scopes_rails/state_machine/scopes'

module Delivery::ContactEmailScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :subscribed_to_deliveries, -> { presented.joins(:subscriptions).where 'subscriptions.subscription_type = ?', :deliveries }
    scope :with_email, -> { presented.where.not email: nil }
    scope :presented, -> { active }
  end
end
