class Api::Admin::EventsController < Api::Admin::ApplicationController
  def index
    @events = Event.confirmed
    render json: { model: 'Event', list: @events.to_json(only: [:id, :title]) }
  end
end
