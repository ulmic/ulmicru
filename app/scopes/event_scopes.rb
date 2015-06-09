module EventScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where.not(state: :removed) }
    scope :declined, -> { where(state: :declined)  }
    scope :confirmed, -> { where(state: :confirmed).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed)  }
    scope :future, -> { where('begin_date >= ?', DateTime.now).where.not(state: :removed) }
    scope :current, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now).where.not(state: :removed) }
    scope :active, -> { where('end_date > ?', DateTime.now).where.not(state: :removed)  }
    scope :past, -> { where('end_date <= ?', DateTime.now).where.not(state: :removed) }
    scope :near_future, -> { where('begin_date <= ?', DateTime.now + 3.month).order('end_date DESC') }
  end
end
