class PositionForm < ActiveForm::Base
  self.main_model = :position

  attributes :title, :member_id, :begin_date, :end_date
end
