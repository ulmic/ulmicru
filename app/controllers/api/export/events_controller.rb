class Api::Export::EventsController < Api::Export::ApplicationController
  def index
    events = Event.all
    render json: events,
           each_serializer: EventPresenter,
           status: :ok
  end
end
