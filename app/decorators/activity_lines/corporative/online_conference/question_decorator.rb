class ActivityLines::Corporative::OnlineConference::QuestionDecorator < ApplicationDecorator
  delegate_all

  def name
    object.text
  end

  def answer_link
    if object.answer_timestamp.present?
      minute = object.answer_timestamp.match(/\d+:/).to_s[0..-2]
      second = object.answer_timestamp.match(/:\d+/).to_s[1..-1]
      "#{object.online_conference.video_link}?t=#{minute}m#{second}s"
    end
  end

  def self.collections
    [ :unviewed, :asked, :answered, :removed ]
  end
end
