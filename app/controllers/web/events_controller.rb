class Web::EventsController < Web::ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = ::Event.find(params[:id]).decorate
    organizers = @event.registrations.organizers.first 10
    attenders = @event.registrations.attenders.first 10 - organizers.count
    @registrations = organizers + attenders
    other_organizers = @event.registrations.organizers.offset organizers.count
    other_attenders = @event.registrations.attenders.offset attenders.count
    @other_registrations = other_organizers + other_attenders
  end
end
