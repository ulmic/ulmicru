class TestPaperDecorator < ApplicationDecorator
  delegate_all

  def full_duration
    if begin_date.day == end_date.day && begin_date.month == end_date.month && begin_date.year == end_date.year
      "#{I18n.l(begin_date, format: '%d %b %Y')} #{begin_date.strftime('%H:%m')} - #{end_date.strftime('%H:%m')}"
    else
      "#{I18n.l(begin_date, format: '%d %b %Y %H:%m')} - #{I18n.l(end_date, format: '%d %b %Y %H:%m')}"
    end
  end

  def show_attributes
    [:title, :full_duration]
  end
end
