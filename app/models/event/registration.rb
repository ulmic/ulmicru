class Event::Registration < ActiveRecord::Base
  belongs_to :event
  has_one :user
end
