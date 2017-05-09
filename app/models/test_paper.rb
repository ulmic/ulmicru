class TestPaper < ActiveRecord::Base
  has_many :questions

  extend Enumerize
  enumerize :record_type, in: [ :confession ]

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :active
    end
  end

  include StateMachine::Scopes

  scope :presented , -> { where.not state: :removed }
  scope :future, -> { where('begin_date >= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
  scope :current, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now).where.not(state: :removed).order('id DESC') }
  scope :past, -> { where('end_date <= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title ]
end
