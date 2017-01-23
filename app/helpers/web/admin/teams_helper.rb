module Web::Admin::TeamsHelper
  def team_types
    team_types = t('activerecord.attributes.team.types')
    team_types.reduce({}) do |types, value|
      types.merge! value[1] => "Team::#{value[0].to_s.capitalize}"
    end
  end

  def team_types_name(type)
    t("activerecord.attributes.team.types.#{type.split(':').last.downcase}")
  end

  def teams_hash(teams)
    teams.reduce({}) do |teams_hash, team|
      teams_hash.merge! team.full_title => team.id
    end
  end

  def projects_hash(projects)
    projects.reduce({}) do |hash, project|
      hash.merge! project.title => project.id
    end
  end
end
