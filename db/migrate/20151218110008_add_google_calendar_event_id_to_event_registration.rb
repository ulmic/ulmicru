class AddGoogleCalendarEventIdToEventRegistration < ActiveRecord::Migration
  def change
    add_column :event_registrations, :google_calendar_event_id, :string
  end
end
