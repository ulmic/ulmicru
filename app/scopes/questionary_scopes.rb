module QuestionaryScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :unviewed, -> { where(member_state: :unviewed).order('id DESC') }
    scope :presented, -> { where.not(state: :removed) }
    scope :on_the_trial, -> { where state: :on_the_trial }
    scope :removed, -> { where state: :removed }
  end
end
