class TeamDecorator < ApplicationDecorator
  delegate_all

  def short_description
    "#{strip_tags(model.description)[0..50]}..."
  end

  def full_title(type_case = nil)
    team_type = I18n.t("activerecord.attributes.team.types.#{type.split(':').last.downcase}")
    if object.is_departament?
      "#{type_case ? send(type_case, team_type) : team_type} в #{municipality}е"
    else
      type_case ? send(type_case, title) : title
    end
  end

  def head_name
    member.decorate.short_name if member
  end

  def name
    title
  end
end
