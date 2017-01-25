class ActivityLines::Lider::YaLider::ParticipantDecorator < ApplicationDecorator
  delegate_all

  def full_name
    object.user.decorate.short_name
  end

  def small_avatar
    object.user.avatar.small
  end

  def is_member?
    user.is_member? && user.member_confirmed?
  end
end
