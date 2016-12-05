class ActivityLines::Corporative::OnlineConference < ActiveRecord::Base
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

  include ActivityLines::Corporative::OnlineConferenceScopes

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title, :video_link ]
end
