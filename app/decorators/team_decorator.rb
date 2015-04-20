class TeamDecorator < ApplicationDecorator
  delegate_all

  def short_description
    "#{ActionController::Base.helpers.strip_tags(model.description)[0..50]}..."
  end

  def full_title
    if object.is_departament?
      "#{I18n.t("activerecord.attributes.team.types.#{type.split(':').last.downcase}")} в #{municipality}е"
    else
      title
    end
  end

  def head_name
    member.decorate.short_name if member
  end
end
