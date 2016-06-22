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
      end
  end
end
