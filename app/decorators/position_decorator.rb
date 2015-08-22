class PositionDecorator < ApplicationDecorator
  delegate_all

  def end_date_datetime
    object.end_date ? I18n.l(object.end_date.to_datetime, format: '%d.%m.%Y') : object.end_date
  end
end
