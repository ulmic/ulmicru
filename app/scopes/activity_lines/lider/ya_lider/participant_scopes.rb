require 'scopes_rails/state_machine/scopes'

module ActivityLines::Lider::YaLider::ParticipantScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
