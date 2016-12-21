class ActivityLines::Lider::YaLider < ActiveRecord::Base
  validates :contest_number, presence: true, uniqueness: true
  validates :contest_year, presence: true, uniqueness: true

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
  pg_search_scope :search_everywhere, against: [:contest_year, :contest_number]
end
