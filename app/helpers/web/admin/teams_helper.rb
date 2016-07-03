module Web::Admin::TeamsHelper
  def team_types
    team_types = t('activerecord.attributes.team.types')
    types = {}
    team_types.each do |key, value|
      types[value] = "Team::#{key.to_s.capitalize}"
    end
    types
  end

  def team_types_name(type)
    t("activerecord.attributes.team.types.#{type.split(':').last.downcase}")
  end

  def teams_hash(teams)
    teams_hash = {}
    teams.each do |team|
      teams_hash[team.full_title] = team.id
    end
    teams_hash
  end
end
