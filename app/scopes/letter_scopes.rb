module LetterScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :unviewed, -> { where(state: :unviewed).order('number DESC') }
    scope :sended, -> { where(state: :sended).order('number DESC') }
    scope :presented, -> { where.not(state: :removed) }
  end
end
