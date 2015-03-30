class EventDecorator < Draper::Decorator
  delegate_all

  def full_duration
    if begin_date.day == end_date.day && begin_date.month == end_date.month && begin_date.year == end_date.year
      "#{I18n.l(begin_date, format: '%d %b %Y')} #{begin_date.to_s.match(/[0-9]{2}:[0-9]{2}/)} - #{end_date.to_s.match(/[0-9]{2}:[0-9]{2}/)}"
    else
      "#{I18n.l(begin_date, format: '%d %b %Y %H:%m')} - #{I18n.l(end_date, format: '%d %b %Y %H:%m')}"
    end
  end

  def full_date_duration
    if begin_date.day == end_date.day && begin_date.month == end_date.month && begin_date.year == end_date.year
      "#{I18n.l(begin_date, format: '%d %b %Y')} #{begin_date.to_s.match(/[0-9]{2}:[0-9]{2}/)} - #{end_date.to_s.match(/[0-9]{2}:[0-9]{2}/)}"
    else
      "#{I18n.l(begin_date, format: '%d %b %Y')} - #{I18n.l(end_date, format: '%d %b %Y')}"
    end
  end

  def lead
    "#{object.description.first(150)}..."
  end
end
