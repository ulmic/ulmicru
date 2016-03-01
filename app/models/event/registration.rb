class Event::Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: [ :event_id ] }

  extend Enumerize
  enumerize :role, in: [ :participant, :organizer ], default: :participant
end
