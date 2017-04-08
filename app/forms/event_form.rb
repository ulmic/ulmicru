class EventForm < ApplicationForm
  self.main_model = :event

  attributes :title, :description, :main_photo, :creator_id, :begin_date, :end_date, :activity_line_id, 
             :organizer_type, :organizer_id, required: true
  attributes :place_ids

  association :registrations do
    attributes :user_id, :event_id, :role
  end
end
