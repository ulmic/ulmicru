class MemberDecorator < Draper::Decorator
  delegate_all
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
    "#{municipality}, #{locality}"
  end

  def position_duration
    last_held_position = positions.last_held_position
    positions.last_held_position.duration if last_held_position.present?
  end

  def main_position_title
    for_now_positions = positions.for_now
    return for_now_positions.first.title if for_now_positions.any?
    last_held_position = positions.last_held_position
    unless last_held_position == []
      last_held_position.title if last_held_position
    end
  end

  def ticket_number
    "№ #{ticket}"
  end
end
