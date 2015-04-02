class EventForm < ApplicationForm
  self.main_model = :event

  attributes :title, :description, :main_photo, :creator_id, :begin_date, :end_date, :activity_line_id, required: true
end
