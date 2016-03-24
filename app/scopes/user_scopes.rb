require 'scopes_rails/state_machine/scopes'

module UserScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :admins, -> { where role: :admin }
    scope :presented, -> { where.not(state: :removed).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed, type: nil).where.not(email: nil).order('id DESC') }
  end
end
