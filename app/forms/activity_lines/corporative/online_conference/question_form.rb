class ActivityLines::Corporative::OnlineConference::QuestionForm < ApplicationReform
  properties :text, :user_id, :online_conference_id, :state, :answer_timestamp

  attr_accessor :anonym
end
