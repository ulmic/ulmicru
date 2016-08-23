require 'scopes_rails/state_machine/scopes'

module LetterScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :unviewed, -> { where(state: :unviewed).order('number DESC') }
    scope :sended, -> { where(state: :sended).order('number DESC') }
    scope :presented, -> { where.not(state: :removed) }
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  end
end
