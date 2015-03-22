class ActivityLineForm < ActiveForm::Base
  self.main_model = :activity_line

  attributes :title, :found_date, :activity_type, :description, :creator_id, required: true
end
