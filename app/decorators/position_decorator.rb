class PositionDecorator < ApplicationDecorator
  delegate_all

  decorates_association :member

  def name
    object.title
  end

  def full_title
    if object.status.acting?
      h.content_tag :span do
        h.concat(h.content_tag(:span, 'data-tooltip' => 'data-tooltip', 'aria-haspopup' => true, class: 'has-tip', title: t('tooltip.position.status.acting'), name: :fuck) do 
          fa_icon 'clock-o' 
        end)
        h.concat ' '
        h.concat object.title
      end
    else
      object.title
    end
  end

  def end_date_datetime
    # FIXME change for_now type
    if for_now == '1'
      I18n.t('activerecord.attributes.position.for_now')
    else
      object.end_date ? I18n.l(object.end_date.to_datetime, format: '%d.%m.%Y') : object.end_date
    end
  end
end
