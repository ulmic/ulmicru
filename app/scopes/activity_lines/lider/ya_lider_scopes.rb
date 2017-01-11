require 'scopes_rails/state_machine/scopes'

module ActivityLines::Lider::YaLiderScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :current, -> { active.where contest_year: (DateTime.now.month > 8 ? DateTime.now.year + 1 : DateTime.now.year) }
    scope :past, -> { active.where 'contest_year < ?', (DateTime.now.month > 8 ? DateTime.now.year + 1 : DateTime.now.year) }
  end
end
