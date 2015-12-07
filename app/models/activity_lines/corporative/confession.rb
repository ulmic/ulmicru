class ActivityLines::Corporative::Confession < ActiveRecord::Base
  belongs_to :member

  validates :year, presence: true
  validates :member_id, presence: true
  validates :nomination, presence: true
  validates :state, presence: true

  include ActivityLines::Corporative::ConfessionScopes
  extend Enumerize
  enumerize :nomination, in: [ :debut, :number_one ]

  include PgSearch
  pg_search_scope :search_everywhere, against: [:year, :nomination],
                                      associated_against: {
                                        member: [ :first_name, :patronymic, :last_name ]
                                      }

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :on_vote
    state :confirmed
    state :declined
    state :removed

    event :confirm do
      transition all => :confirmed
    end

    event :to_vote do
      transition all => :on_vote
    end

    event :remove do
      transition all => :removed
    end
  end
end
