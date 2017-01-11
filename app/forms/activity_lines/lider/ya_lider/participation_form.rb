class ActivityLines::Lider::YaLider::ParticipationForm < ApplicationReform
  properties :participant_id, :stage_id, :state

  validates :participant_id, presence: true
  validates :stage_id, presence: true
end
