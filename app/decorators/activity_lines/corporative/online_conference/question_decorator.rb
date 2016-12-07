class ActivityLines::Corporative::OnlineConference::QuestionDecorator < ApplicationDecorator
  delegate_all

  def answer_link
    if object.answer_timestamp.present?
      minute = object.answer_timestamp.match(/\d:/)[0..-2]
      second = object.answer_timestamp.match(/:\d/)[1..-1]
      "#{object.video_link}?t=#{minute}m#{second}s"
    end
  end

  def self.collections
    [ :unviewed, :asked, :answered, :removed ]
  end
end
