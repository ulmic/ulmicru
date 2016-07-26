require 'scopes_rails/state_machine/scopes'

module FeedbackScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
