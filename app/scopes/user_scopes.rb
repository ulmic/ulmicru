require 'scopes_rails/state_machine_scopes'

module UserScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :admins, -> { where role: :admin }
    scope :presented, -> { where.not(state: :removed).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed, type: nil).where.not(email: nil).order('id DESC') }
  end
end
