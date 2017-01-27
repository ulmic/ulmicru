class ActivityLines::Corporative::MeritForm < ApplicationReform
  properties :user_id, :nomination, :year, :state

  validates :user_id, presence: true
  validates :nomination, presence: true
  validates :year, presence: true
end
