class RegistrationPresenter < ApplicationPresenter
  attributes :user_id, :event_id, :role, :google_calendar_event_id

  has_one :user , serializer: ::UserPresenter
end
