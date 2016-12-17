require 'scopes_rails/state_machine/scopes'

module Oauth::AppScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
