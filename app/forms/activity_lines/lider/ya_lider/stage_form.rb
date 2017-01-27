class ActivityLines::Lider::YaLider::StageForm < ApplicationReform
  properties :number, :contest_id, :title, :begin_date, :end_date

  validates :number, presence: true
  validates :contest_id, presence: true
  validates :title, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true
end
