class Place < ActiveRecord::Base
  has_and_belongs_to_many :events

  validates :title, uniqueness: true
  validates :url, uniqueness: true

  state_machine :state, initial: :unviewed do
    state :active
    state :unviewed
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :active
    end
  end

  include StateMachine::Scopes

  scope :presented, -> { where.not state: :removed }
  scope :need_to_review, -> { unviewed }

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :description, :longitude, :latitude, :foursquare_uid]

  def self.collections
    [:unviewed, :active, :removed]
  end
end
