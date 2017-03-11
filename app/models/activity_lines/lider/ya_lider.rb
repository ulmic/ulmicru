class ActivityLines::Lider::YaLider < ActiveRecord::Base
  has_many :stages, foreign_key: :contest_id, class_name: 'ActivityLines::Lider::YaLider::Stage'
  has_many :tokens, as: :record, dependent: :destroy
  has_one :committee, as: :project, class_name: 'Team::Committee'
  has_many :participants, class_name: 'ActivityLines::Lider::YaLider::Participant', foreign_key: :contest_id
  has_one :fair_idea, as: :project, class_name: 'Event'

  validates :contest_number, presence: true, uniqueness: { scope: :state }
  validates :contest_year, presence: true, uniqueness: { scope: :state }
  validates :provision, presence: true

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

  def last_stage
    stages.order(:number).last
  end

  def stage(number)
    stages.where(number: number).first
  end

  def current_stage
    stages.map do |stage|
      stage if stage.during?
    end.compact.first
  end

  def self.current_contest
    where(contest_number: configus.activity_lines.lider.ya_lider.current_contest_number).first
  end
end
