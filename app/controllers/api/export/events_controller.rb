class Api::Export::EventsController < Api::Export::ApplicationController
  def index
    events = Event.all
    render json: events,
           each_serializer: EventPresenter,
           included: [ :places, :users ],
           status: :ok
  end
end
