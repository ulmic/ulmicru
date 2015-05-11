class Event::Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  include Event::RegistrationScopes
  extend Enumerize
  enumerize :role, in: [ :participant, :organizer ], default: :participant
end
