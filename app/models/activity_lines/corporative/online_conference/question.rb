class ActivityLines::Corporative::OnlineConference::Question < ActiveRecord::Base
  belongs_to :online_conference, class_name: 'ActivityLines::Corporative::OnlineConference'
end
