require 'scopes_rails/state_machine_scopes'

module FeedbackScopes
  extend ActiveSupport::Concern
  include StateMachineScopes
end
