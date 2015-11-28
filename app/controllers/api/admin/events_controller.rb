class Api::Admin::EventsController < Api::Admin::ApplicationController
  def index
    if params[:q].present?
      @events = Event.confirmed.search_everywhere params[:q]
    else
      @events = Event.confirmed
    end
    render json: { model: 'Event', list: @events.to_json(only: [:id, :title]) }
  end
end
