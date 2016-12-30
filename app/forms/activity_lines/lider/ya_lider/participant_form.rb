class ActivityLines::Lider::YaLider::ParticipantForm < ApplicationReform
  properties :contest_year, :user_id, :state

  validates :contest_year, presence: true
  validates :user_id, presence: true
end
