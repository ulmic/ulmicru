class ActivityLineDecorator < ApplicationDecorator
  delegate_all

  def short_body
    "#{ActionController::Base.helpers.strip_tags(model.description)[0..50]}..."
  end

  def full_title
    "#{I18n.t("enumerize.activity_line.activity_type.#{object.activity_type}")} «#{object.title}»"
  end

end
