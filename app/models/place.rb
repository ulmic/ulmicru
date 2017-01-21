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

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :description, :longitude, :latitude, :foursquare_uid]
end
