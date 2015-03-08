class Event < ActiveRecord::Base
  extend Enumerize
  has_one :user, as: :creator

  enumerize :type, in: [:big, :standart]
end
