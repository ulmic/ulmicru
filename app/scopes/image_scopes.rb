require 'scopes_rails/state_machine/scopes'

module ImageScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
