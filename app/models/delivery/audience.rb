class Delivery::Audience < ActiveRecord::Base
  extend Enumerize
  belongs_to :campaign, class_name: 'Delivery::Campaign'

  validates :audience_type, presence: true

  enumerize :audience_type, in: [ :team, :users, :contact_emails, :event_registrations ], default: :users

  def contacts
    contacts = []
    case audience_type
    when 'users'
      contacts = User.subscribed_to_deliveries
    when 'contacts_emails'
      [User, ContactEmail].each do |type|
        type.subscribed_to_deliveries.find_each(batch_size: 1000) do |instance|
          contacts << OpenStruct.new(email: instance.email, first_name: instance.first_name, last_name: instance.last_name)
        end
      end
    when 'team'
      team = Team.find audience_id
      contacts = team.users.subscribed_to_deliveries
    when 'event_registrations'
      event = Event.find audience_id
      contacts = User.subscribed_to_deliveries.where id: event.registrations.map(&:user_id)
    end
    contacts
  end
end
