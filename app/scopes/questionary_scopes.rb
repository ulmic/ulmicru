require 'scopes_rails/state_machine/scopes'

module QuestionaryScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :unviewed, -> { where(member_state: :unviewed).order('id DESC') }
    scope :presented, -> { where.not(state: :removed) }
    scope :member_on_the_trial, -> { where(member_state: :on_the_trial).order(request_date: :desc) }
    scope :member_declined, -> { where(member_state: :declined).order(request_date: :desc) }
    scope :member_trial_passed, -> { where(member_state: :trial_passed).order(request_date: :desc)}
    scope :member_changes_expectation, -> { where(member_state: :changes_expectation).order(request_date: :desc) }
    scope :need_to_review, -> { where 'member_state = \'unviewed\' OR member_state = \'updated\'' }
  end
end
