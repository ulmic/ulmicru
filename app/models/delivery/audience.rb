class Delivery::Audience < ActiveRecord::Base
  extend Enumerize
  belongs_to :campaign, class_name: 'Delivery::Campaign'

  validates :audience_type, presence: true

  enumerize :audience_type, in: [ :team, :users, :contact_emails, :event_registrations ], default: :users

  def title
    case audience_type
    when 'team'
      Team.find(audience_id).decorate.full_title
    when 'event_registrations'
      Event.find(audience_id).decorate.full_title
    end
  end
end
