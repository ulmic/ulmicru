class Events::OnlineConference < ActiveRecord::Base
  state_machine :state, initial: :active do
    state :active
    state :removed

    event :restore do
      transition all => :active
    end
    event :remove do
      transition all => :removed
    end
  end

  include Events::OnlineConferenceScopes
end
