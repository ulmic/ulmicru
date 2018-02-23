class Api::Export::EventsController < Api::Export::ApplicationController
  def index
    events = Event.all
    render json: events,
           each_serializer: EventPresenter,
           includes: [ :places, :registrations ],
           status: :ok
  end
end
