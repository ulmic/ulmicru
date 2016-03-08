require 'scopes_rails/state_machine_scopes'

module EventScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :presented, -> { where.not(state: :removed) }
    scope :future, -> { where('begin_date >= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
    scope :current, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now).where.not(state: :removed).order('id DESC') }
    scope :past, -> { where('end_date <= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
    scope :near_future, -> { where('begin_date <= ?', DateTime.now + 3.month).order('begin_date DESC') }
  end
end
