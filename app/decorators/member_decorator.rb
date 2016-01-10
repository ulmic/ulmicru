class MemberDecorator < UserDecorator
  delegate_all

  decorates_association :teams

  def full_name
    "#{first_name} #{patronymic} #{last_name}"
  end

  def name
    full_name
  end

  def short_name
    "#{first_name} #{last_name}"
  end

  def place
    if municipality.include? 'г.'
      locality
    else
      "#{municipality}, #{locality}"
    end
  end

  def position_duration
    last_held_position = positions.last_held_position
    last_held_position.duration if last_held_position.present?
  end

  def main_position_title
    for_now_positions = positions.current_positions
    return for_now_positions.first.title if for_now_positions.any?
    last_held_position = positions.last_held_position
    unless last_held_position == []
      last_held_position.title if last_held_position
    end
  end

  def ticket_number
    "№ #{ticket}"
  end

  def parent_avatar
    parent.avatar.medium if parent.present?
  end

  def profile_avatar
    avatar.profile if avatar
  end

  def element_avatar
    if avatar.present? && confirmed?
      avatar.element
    else
      default_avatar
    end
  end
end
