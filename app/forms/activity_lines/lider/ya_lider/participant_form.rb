class ActivityLines::Lider::YaLider::ParticipantForm < ApplicationReform
  properties :contest_id, :user_id, :state

  validates :contest_id, presence: true
  validates :user_id, presence: true
end
