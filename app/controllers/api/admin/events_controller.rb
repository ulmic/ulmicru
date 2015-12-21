class Api::Admin::EventsController < Api::Admin::ApplicationController
  def index
    if params[:q].present?
      @events = Event.confirmed.search_everywhere params[:q][:term]
    else
      @events = Event.confirmed
    end
    render json: @events.to_json(only: [:id, :title])
  end
end
