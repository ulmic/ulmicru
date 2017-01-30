class ActivityLines::Lider::YaLider::ParticipationDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.stage.title} | #{object.participant.user.decorate.short_name}"
  end
end
