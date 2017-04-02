class ActivityLines::Lider::YaLider::ParticipantEvent < ActiveRecord::Base
  has_many :fields, class_name: 'ActivityLines::Lider::YaLider::EventField', foreign_key: :event_id

  belongs_to :participant, class_name: 'ActivityLines::Lider::YaLider::Participant'
  belongs_to :event
end
