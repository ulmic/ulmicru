require 'scopes_rails/state_machine/scopes'

module TestPaper::QuestionScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
