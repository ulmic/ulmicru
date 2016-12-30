class ActivityLines::Lider::YaLider::Participant < ActiveRecord::Base
  belongs_to :user

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :won
    state :lost
    state :removed
    state :declined

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :active
    end
  end
end
