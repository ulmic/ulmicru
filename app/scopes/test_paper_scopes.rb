require 'scopes_rails/state_machine/scopes'

module TestPaperScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :presented , -> { where.not state: :removed }
    scope :future, -> { where('begin_date >= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
    scope :current, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now).where.not(state: :removed).order('id DESC') }
    scope :past, -> { where('end_date <= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
  end
end
