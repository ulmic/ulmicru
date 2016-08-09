class PositionForm < ApplicationReform
  properties :title, :member_id, :begin_date, :end_date, :for_now, :state

  validates :member_id, presence: true
end
