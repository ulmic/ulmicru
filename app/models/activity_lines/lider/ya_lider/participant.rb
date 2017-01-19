class ActivityLines::Lider::YaLider::Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest, class_name: 'ActivityLines::Lider::YaLider'
  has_many :participations, class_name: 'ActivityLines::Lider::YaLider::Participation'
  has_many :fields, class_name: 'ActivityLines::Lider::YaLider::ParticipantField'

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :won
    state :lost
    state :removed
    state :declined

    event :confirm do
      transition all => :active
    end

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :active
    end
  end
end
