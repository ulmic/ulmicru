class ActivityLines::Corporative::Confession < ActiveRecord::Base
  validates :year, presence: true
  validates :member_id, presence: true
  validates :nomination, presence: true
  validates :state, presence: true

  extend Enumerize
  enumerize :nomination, in: [ :debut, :number_one ]

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :on_vote
    state :confirmed
    state :declined
    state :removed

    event :to_vote do
      transition all => :on_vote
    end

    event :remove do
      transition all => :removed
    end
  end
end
