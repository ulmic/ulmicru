class Delivery::AudienceDecorator < ApplicationDecorator
  delegate_all

  def title
    case audience_type
    when 'team'
      Team.find(audience_id).decorate.full_title
    when 'event_registrations'
      Event.find(audience_id).decorate.full_title
    end
  end

  def contacts
    contacts = []
    case audience_type
    when 'users'
      contacts = User.all
    when 'contacts_emails'
      [User, ContactEmail].each do |type|
	type.find_each(batch_size: 1000) do |instance|
	  contacts << OpenStruct.new(email: instance.email, first_name: instance.first_name, last_name: instance.last_name)
	end
      end
    when 'team'
      team = Team.find audience_id
      contacts = team.users
    when 'event_registrations'
      event = Event.find audience_id
      contacts = event.registrations.map &:user
    end
    contacts
  end
end
