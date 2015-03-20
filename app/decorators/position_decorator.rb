class PositionDecorator < Draper::Decorator
  delegate_all

  def post
    unless end_date == :for_now
      duration = "#{I18n.t('helpers.from')} #{begin_date.year}"
      if begin_date.year == end_date.to_datetime.year
        duration += " #{I18n.t('helpers.until')} #{end_date.to_s.year}"
      end
    end
    "#{title} #{duration}"
  end
end
