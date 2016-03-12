class PositionDecorator < ApplicationDecorator
  delegate_all

  decorates_association :member

  def end_date_datetime
    if for_now
      I18n.t('activerecord.attributes.position.for_now')
    else
      object.end_date ? I18n.l(object.end_date.to_datetime, format: '%d.%m.%Y') : object.end_date
    end
  end
end
