class ActivityLines::Corporative::OnlineConferenceDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end

  def self.collections
    [ :future, :past, :removed ]
  end

  def event_title
    "#{I18n.t('activerecord.attributes.activity_lines/corporative/online_conference.event_title')} «#{object.title}»"
  end

  def show_attributes
    [ :title, :formatted_date, :video_link_to, :event_link ]
  end
  
  def formatted_date
    I18n.l(object.date, format: '%d %B %Y')
  end

  def video_link_to
    h.content_tag(:a, href: object.video_link) do
      object.video_link
    end
  end

  def event_link
    h.content_tag(:a, href: event_path(object.event)) do
      object.event.title
    end
  end
end
