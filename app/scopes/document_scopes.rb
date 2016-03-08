require 'scopes_rails/state_machine_scopes'

module DocumentScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :presented, -> { where.not(state: :removed).order('id ASC') }
  end
end
