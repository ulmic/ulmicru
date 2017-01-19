require 'scopes_rails/state_machine/scopes'

module ActivityLines::Lider::YaLider::ParticipationScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes
end
