module Web::Admin::EventsHelper
  # FIXME запросы из хелпера
  def organizer_types
    hash = {}
    Event.organizer_type.values.each do |value|
      hash[t("activerecord.models.#{value.downcase}")] = value
    end
    hash
  end

  def teams_and_members_hash(teams, members)
    hash = {}
    if teams
      teams_array = []
      teams.each do |team|
        teams_array << [ team.id, team.full_title ]
      end
      hash[:teams] = teams_array
    end
    if members
      members_array = []
      members.each do |member|
        members_array << [ member.id, "#{member.ticket} | #{member.full_name}" ]
      end
      hash[:members] = members_array
    end
    hash
  end
end
