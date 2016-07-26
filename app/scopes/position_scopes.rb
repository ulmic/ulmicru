require 'scopes_rails/state_machine/scopes'

module PositionScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :current_positions, -> { where for_now: 1 }
    scope :last_held_position, -> { order('end_date DESC').first }
  end
end
