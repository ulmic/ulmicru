module LetterScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :unviewed, -> { where state: :unviewed }
    scope :sended, -> { where state: :sended }
    scope :removed, -> { where state: :removed }
  end
end
