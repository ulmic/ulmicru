class ActivityLineDecorator < ApplicationDecorator
  delegate_all

  def short_body
    "#{strip_tags(model.description)[0..50]}..."
  end

  def full_title(type_case = nil)
    if object.activity_type.corporative? || object.activity_type.event_line?
      if type_case
        send type_case, object.title
      else
        object.title
      end
    else
      type = I18n.t("enumerize.activity_line.activity_type.#{object.activity_type}")
      if type_case
        "#{send(type_case, type)} «#{object.title}»"
      else
        "#{type} «#{object.title}»"
      end
    end
  end

  def name
    title
  end

end
