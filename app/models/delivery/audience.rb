class Delivery::Audience < ActiveRecord::Base
  extend Enumerize
  belongs_to :campaign, class_name: 'Delivery::Campaign'

  validates :audience_type, presence: true

  enumerize :audience_type, in: [ :team, :users, :contact_emails, :event_registrations, :members ], default: :users

  def contacts
    case audience_type
    when 'users'
      User.presented.subscribed_to_deliveries.with_email
    when 'members'
      Member.presented.subscribed_to_deliveries.with_email
    when 'contacts_emails'
      [User, ContactEmail].reduce([]) do |contacts, type|
        type.presented.subscribed_to_deliveries.with_email.find_each(batch_size: 1000) do |instance|
          contacts << OpenStruct.new(email: instance.email, first_name: instance.first_name, last_name: instance.last_name)
        end
      end
    when 'team'
      team = Team.find audience_id
      team.users.presented.subscribed_to_deliveries.with_email
    when 'event_registrations'
      event = Event.find audience_id
      User.presented.subscribed_to_deliveries.with_email.where id: event.registrations.map(&:user_id)
    end
  end
end
