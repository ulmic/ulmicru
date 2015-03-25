class Event < ActiveRecord::Base
  extend Enumerize
  belongs_to :creator, class_name: User

  enumerize :event_type, in: [ :big, :standart ]

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :removed

    event :confirm do
      transition all => :confirmed
    end

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :unviewed
    end
  end
end
