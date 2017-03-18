class ActivityLines::Lider::EventsYaLider < ActiveRecord::Base
  extend Enumerize
  enumerize :association_type, in: [ :fair_idea, :real_life ]

  belongs_to :event, class_name: 'Event'
end
