class Delivery::Audience < ActiveRecord::Base
  extend Enumerize
  belongs_to :campaign, class_name: 'Delivery::Campaign'
  belongs_to :project

  validates :audience_type, presence: true

  enumerize :audience_type, in: [ :team, :users, :contact_emails, :event_registrations, :members, :project ], default: :users

  def contacts
    @contacts ||= case audience_type
      when 'users'
        User.presented.subscribed_to_deliveries.with_email
      when 'members'
        Member.presented.subscribed_to_deliveries.with_email
      when 'contact_emails'
        array = []
        [User, Delivery::ContactEmail].each do |type|
          type.presented.subscribed_to_deliveries.with_email.find_each(batch_size: 1000) do |instance|
            array << OpenStruct.new(email: instance.email,
                                    first_name: instance.first_name,
                                    last_name: instance.last_name,
                                    user_type: type,
                                    id: instance.id)
          end
        end
        array
      when 'team'
        team = Team.find audience_id
        team.users.presented.subscribed_to_deliveries.with_email
      when 'event_registrations'
        event = Event.find audience_id
        User.presented.subscribed_to_deliveries.with_email.where id: event.registrations.map(&:user_id)
      when 'project'
        User.with_email.presented.where id: Subscription.project(audience_id).map(&:user_id)
      end
  end
end
