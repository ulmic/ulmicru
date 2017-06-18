module Web::Admin::Delivery::AudiencesHelper
  def audience_path(audience)
    case audience.audience_type
    when 'users', 'contacts_emails'
      ''
    when 'event_registrations'
      # FIXME query from helper :(
      link_to Event.find(audience.audience_id).title, admin_event_path(audience.audience_id)
    when 'team'
      link_to Team.find(audience.audience_id).title, admin_team_path(audience.audience_id)
    when 'project'
      link_to Project.find(audience.audience_id).title, admin_project_path(audience.audience_id)
    end
  end

  def audience_types_collection(campaign)
    if campaign.audiences.any?
      except = [:users, :contact_emails].map &:to_s
    else
      except = []
    end
    arr = []
    ::Delivery::Audience.audience_type.values.each_with_index do |v, index|
      next if except.include? v
      arr << [t("enumerize.delivery/audience.audience_type.#{v}"), v] 
    end
    arr
  end
end
