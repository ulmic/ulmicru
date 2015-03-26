module EventScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where.not(state: :removed) }
    scope :declined, -> { where(state: :declined)  }
    scope :unviewed, -> { where(state: :unviewed)  }
    scope :future, -> { where('begin_date >= ?', DateTime.now) }
    scope :current, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now) }
    scope :past, -> { where('end_date <= ?', DateTime.now) }
  end
end
