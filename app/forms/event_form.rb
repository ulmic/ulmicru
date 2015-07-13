class EventForm < ApplicationForm
  self.main_model = :event

  attributes :title, :description, :main_photo, :place, :creator_id, :begin_date, :end_date, :activity_line_id, :organizer_type, :organizer_id, required: true

  association :registrations do
    attributes :user_id, :event_id, :role, required: true
  end
end
