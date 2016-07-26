require 'scopes_rails/state_machine/scopes'

module DocumentScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :presented, -> { where.not(state: :removed).order('id ASC') }
  end
end
