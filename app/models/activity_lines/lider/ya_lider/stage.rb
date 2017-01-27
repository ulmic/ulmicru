class ActivityLines::Lider::YaLider::Stage < ActiveRecord::Base
  belongs_to :contest, class_name: 'ActivityLines::Lider::YaLider'
  has_many :participations, class_name: 'ActivityLines::Lider::YaLider::Participation'
  has_many :participants, through: :participations

  validates :number, presence: true, uniqueness: { scope: :contest_id }

  include DurationManagment

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

  def next_stage
    contest.stages.where(number: number + 1).first
  end

  def current_participants
    participants.active.map do |participant|
      participant unless participant.participations.active.where(stage_id: next_stage.id).any?
    end.compact.map &:decorate
  end
end
