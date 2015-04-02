class Event::Registration < ActiveRecord::Base
  belongs_to :event
  has_one :user

  extend Enumerize
  enumerize :role, in: [ :participant, :organizer ], default: :participant
end
