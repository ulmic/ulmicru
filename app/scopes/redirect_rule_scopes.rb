require 'scopes_rails/state_machine/scopes'

module RedirectRuleScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
