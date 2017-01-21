require 'scopes_rails/state_machine/scopes'

module PlaceScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :presented, -> { where.not state: :removed }
  end
end
