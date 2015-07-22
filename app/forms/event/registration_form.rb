class Event::RegistrationForm < ApplicationForm
  self.main_model = 'event/registration'

  attributes :user_id, :event_id, :role, require: true
end
