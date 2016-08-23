require 'scopes_rails/state_machine/scopes'

module FeedbackScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  end
end
