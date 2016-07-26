require 'scopes_rails/state_machine/scopes'

module CategoryScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :roots, -> { presented.where(parent_id: nil)}
    scope :last_childs, -> { where is_last: true }
    scope :presented, -> { where.not state: :removed}
  end
end
