class Event::RegistrationForm < ApplicationForm
  self.main_model = 'event/registration'

  attributes :user_id, :event_id, :google_calendar_event_id, :role, require: true
end
