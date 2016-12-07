require 'scopes_rails/state_machine/scopes'

module ActivityLines::Corporative::OnlineConference::QuestionScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :need_to_review, -> { unviewed }
    scope :asked, -> { active.where answer_timestamp: nil }
    scope :answered, -> { active.where.not answer_timestamp: nil }
  end
end
