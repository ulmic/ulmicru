class TagDecorator < ApplicationDecorator
  delegate_all

  decorates_association :target

  def just_text
    case tag_type
    when 'string'
      object.text
    when 'link'
      case target_type
      when 'Member'
        "#{object.target.ticket} | #{object.target.first_name} #{object.target.last_name}"
      when 'Team'
        object.target.title
      when 'ActivityLine'
        object.target.title
      when 'Event'
        object.target.title
      end
    end
  end
end
