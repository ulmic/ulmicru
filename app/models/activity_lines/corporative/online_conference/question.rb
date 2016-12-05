class ActivityLines::Corporative::OnlineConference::Question < ActiveRecord::Base
  belongs_to :online_conference, class_name: 'ActivityLines::Corporative::OnlineConference'

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end 
    event :restore do
      transition all => :active
    end
  end
end
