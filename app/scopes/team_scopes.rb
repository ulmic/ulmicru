require 'scopes_rails/state_machine_scopes'

module TeamScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :visible, -> { where publicity: :visible }
    scope :hidden, -> { where publicity: :hidden }
    scope :presented, -> { where.not(state: :removed) }
  end
end
