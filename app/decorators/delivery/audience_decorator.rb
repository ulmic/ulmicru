class Delivery::AudienceDecorator < ApplicationDecorator
  delegate_all

  def title
    case object&.audience_type
    when 'team'
      Team.find(audience_id).decorate.full_title
    when 'event_registrations'
      Event.find(audience_id).decorate.full_title
    end
  end

  def name
    title
  end
end
