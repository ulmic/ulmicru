require 'scopes_rails/state_machine/scopes'

module ActivityLines::Corporative::OnlineConference::QuestionScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
