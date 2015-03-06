class Event < ActiveRecord::Base
  has_one :user, as: :creator

  enumerize :type, in: [:big, :standart]
end
