module LetterScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :unviewed, -> { where(state: :unviewed).order('number DESC') }
    scope :sended, -> { where(state: :sended).order('number DESC') }
  end
end
