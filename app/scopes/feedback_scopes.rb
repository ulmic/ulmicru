module FeedbackScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :unviewed, -> { where(state: :unviewed).order('id DESC') }
    scope :fixing, -> { where(state: :fixing).order('id DESC') }
    scope :done, -> { where(state: :done).order('id DESC') }
    scope :declined, -> { where(state: :declined).order('id DESC') }
  end
end
