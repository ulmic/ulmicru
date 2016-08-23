require 'scopes_rails/state_machine/scopes'

module TeamScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :visible, -> { where publicity: :visible }
    scope :hidden, -> { where publicity: :hidden }
    scope :presented, -> { where.not(state: :removed) }
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  end
end
