class EventForm < ApplicationForm
  self.main_model = :event

  attributes :title, :description, :main_photo, :creator_id, :begin_date, :end_date, 
             :organizer_type, :organizer_id, required: true
  attributes :place_ids, :activity_line_id

  association :registrations do
    attributes :user_id, :event_id, :role
  end
end
