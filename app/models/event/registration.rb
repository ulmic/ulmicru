class Event::Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: [ :event_id ] }

  scope :attenders, -> { where role: :participant }
  scope :organizers, -> { where role: :organizer }
  scope :date_order, -> { order 'created_at DESC' }

  extend Enumerize
  enumerize :role, in: [ :participant, :organizer, :expert ], default: :participant
end
