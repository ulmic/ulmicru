class ActivityLines::Lider::YaLider::ParticipantFieldDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.participant.user.decorate.short_name} #{object.title}"
  end
end
