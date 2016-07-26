class TeamDecorator < ApplicationDecorator
  delegate_all

  def short_description
    "#{strip_tags(model.description)[0..50]}..."
  end

  def full_title(type_case = nil)
    team_type = I18n.t("activerecord.attributes.team.types.#{type.split(':').last.downcase}")
    if object.is_departament?
      "#{type_case ? send(type_case, team_type) : team_type} в #{instrumental(object.municipality)}"
    elsif object.is_primary?
      "#{type_case ? send(type_case, team_type) : team_type} в #{object.school}"
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

  def self.collections
    [ :active, :unviewed, :removed ]
  end

  def place
    case object.type
    when 'depatartament'
      object.municipality
    when 'primary'
      h.content_tag :div do
        h.content_tag :a, href: team_path(object.team) do
          object.team.decorate.full_title
        end
        object.school
      end
    end
  end
end
