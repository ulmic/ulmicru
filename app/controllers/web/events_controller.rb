class Web::EventsController < Web::ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = ::Event.find(params[:id]).decorate
    organizers = @event.registrations.organizers
    attenders = @event.registrations.attenders
    all_registrations = organizers + attenders
    @registrations = all_registrations.first 10
    @other_registrations = all_registrations.drop 10
  end
end
