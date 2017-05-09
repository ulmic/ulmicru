class Feedback < ActiveRecord::Base
  belongs_to :user

  validates :text, presence: true
  validates :url, presence: true
  validates :user_id, presence: true

  include StateMachine::Scopes
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }

  state_machine initial: :unviewed do
    state :unviewed
    state :fixing
    state :done
    state :declined

    event :start do
      transition all => :fixing
    end
    event :finish do
      transition all => :done
    end
    event :decline do
      transition all => :declined
    end
  end
end
