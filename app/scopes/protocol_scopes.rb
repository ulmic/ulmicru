require 'scopes_rails/state_machine/scopes'

module ProtocolScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
