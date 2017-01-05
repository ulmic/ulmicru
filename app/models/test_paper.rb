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

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title ]
end
