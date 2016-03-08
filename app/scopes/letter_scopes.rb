require 'scopes_rails/state_machine_scopes'

module LetterScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :unviewed, -> { where(state: :unviewed).order('number DESC') }
    scope :sended, -> { where(state: :sended).order('number DESC') }
    scope :presented, -> { where.not(state: :removed) }
  end
end
