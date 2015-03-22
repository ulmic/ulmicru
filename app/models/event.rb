class Event < ActiveRecord::Base
  extend Enumerize
  belongs_to :creator, class_name: User

  enumerize :event_type, in: [:big, :standart]
end
