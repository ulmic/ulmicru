class PositionForm < ApplicationForm
  self.main_model = :position

  attributes :title, :member_id, :begin_date, :end_date, :for_now, :state
end
