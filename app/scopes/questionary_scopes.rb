require 'scopes_rails/state_machine/scopes'

module QuestionaryScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :unviewed, -> { where(member_state: :unviewed).order('id DESC') }
    scope :presented, -> { where.not(state: :removed) }
    scope :on_the_trial, -> { where member_state: :on_the_trial }
  end
end
