class MemberDecorator < ApplicationDecorator
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

  def parent_avatar
    parent.avatar.medium if parent.present?
  end

  def profile_avatar
    avatar.profile if avatar
  end

  def select_presentation
    "#{ticket} | #{first_name} #{last_name}"
  end
end
