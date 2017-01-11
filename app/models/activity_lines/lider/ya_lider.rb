class ActivityLines::Lider::YaLider < ActiveRecord::Base
  has_many :stages, foreign_key: :contest_id, class_name: 'ActivityLines::Lider::YaLider::Stage'
  has_many :tokens, as: :record, dependent: :destroy

  validates :contest_number, presence: true, uniqueness: { scope: :state }
  validates :contest_year, presence: true, uniqueness: { scope: :state }

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

  def first_stage
    stages.where(number: 1).first
  end
end
