class Position < ActiveRecord::Base
  belongs_to :member

  validate :begin_before_end_date

  include DurationManagment

  extend Enumerize
  enumerize :status, in: [ :confirmed, :acting ], default: :confirmed

  include StateMachine::Scopes

  scope :current_positions, -> { confirmed.where for_now: 1 }
  scope :last_held_position, -> { order('end_date DESC').first }
  scope :active, -> { where.not state: :removed }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
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
end
