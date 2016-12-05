require 'scopes_rails/state_machine/scopes'

module Events::OnlineConferenceScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :future, -> { active.where('date > ?', DateTime.now) }
    scope :past, -> { active.where('date < ?', DateTime.now) }
  end
end
