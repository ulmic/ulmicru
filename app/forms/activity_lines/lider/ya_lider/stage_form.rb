class ActivityLines::Lider::YaLider::StageForm < ApplicationReform
  properties :number, :ya_lider_id, :title, :begin_date, :end_date

  validates :number, presence: true
  validates :ya_lider_id, presence: true
  validates :title, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true
end
