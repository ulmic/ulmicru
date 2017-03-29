class ActivityLines::Lider::YaLider::Event < ActiveRecord::Base
  has_many :fields, class_name: 'ActivityLines::Lider::YaLider::EventField'

  belongs_to :participant, class_name: 'ActivityLines::Lider::YaLider::Participant'
  belongs_to :event
end
