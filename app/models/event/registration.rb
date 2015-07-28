class Event::Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true,
                      uniqueness: { scope: [ :event_id ] }
  validates :event_id, presence: true

  include Event::RegistrationScopes
  extend Enumerize
  enumerize :role, in: [ :participant, :organizer ], default: :participant
end
