class ActivityLines::Lider::YaLider::ParticipantDecorator < ApplicationDecorator
  delegate_all

  def full_name
    object.user.decorate.short_name
  end
end
