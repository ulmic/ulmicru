class Place < ActiveRecord::Base
  has_and_belongs_to_many :events

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
  pg_search_scope :search_everywhere, against: [:title, :description, :longitude, :latitude, :foursquare_uid]
end