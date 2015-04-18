module Web::Admin::EventsHelper
  def organizer_types
    hash = {}
    Event.organizer_type.values.each do |value|
      hash[t("activerecord.models.#{value.downcase}")] = value
    end
    hash
  end

  def teams_and_members_hash(teams, members)
    hash = {}
    teams_hash = {}
    teams.each do |team|
      teams_hash[team.full_title] = team.id
    end
    members_hash = {}
    members.each do |member|
      members_hash[member.select_presentation] = member.id
    end
    hash[t('activerecord.models.team')] = teams_hash
    hash[t('activerecord.models.member')] = members_hash
    hash
  end
end
