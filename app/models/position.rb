class Position < ActiveRecord::Base
  belongs_to :member

  validate :begin_before_end_date

  include DurationManagment

  state_machine :state, initial: :confirmed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed

    event :confirm do
      transition all => :confirmed
    end

    event :renew do
      transition all => :unviewed
    end

    event :decline do
      transition all => :declined
    end

    event :remove do
      transition all => :removed
    end
  end

  include PositionScopes
end
