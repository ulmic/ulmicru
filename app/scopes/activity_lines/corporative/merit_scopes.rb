require 'scopes_rails/state_machine/scopes'

module ActivityLines::Corporative::MeritScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
