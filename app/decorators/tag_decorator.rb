class TagDecorator < ApplicationDecorator
  delegate_all

  def just_text
    case tag_type
    when 'string'
      objec.text
    when 'link'
      case target_type
      when 'Member'
        "#{object.record.ticket} | #{object.record.first_name} #{object.record.last_name}"
      when 'Team'
        object.record.title
      when 'ActivityLine'
        object.record.title
      when 'Event'
        object.record.title
      end
    end
  end
end
