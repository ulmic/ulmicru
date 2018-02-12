class ActivityLines::Corporative::OnlineConferencePresenter < ApplicationPresenter
  attributes :title, :date, :video_link, :event_id

  def date
    object.date.iso8601
  end
end
