require 'scopes_rails/state_machine/scopes'

module ActivityLines::Lider::YaLiderScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :current, -> { where contest_year: DateTime.now.year }
    scope :past, -> { where 'contest_year < ?', DateTime.now.year }
  end
end
