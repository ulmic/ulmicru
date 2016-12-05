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
end
