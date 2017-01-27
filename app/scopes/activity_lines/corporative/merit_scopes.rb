require 'scopes_rails/state_machine/scopes'

module ActivityLines::Corporative::MeritScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :honorary_members, -> { active.where nomination: :first_degree }
    scope :second_degree, -> { active.where nomination: :second_degree }
  end
end
