class Api::Admin::EventsController < Api::Admin::ApplicationController
  skip_before_filter :authenticate_admin!
  def index
    if params[:q].present?
      @events = ::Event.confirmed.search_everywhere params[:q][:term]
    else
      @events = ::Event.confirmed
    end
    render json: @events.to_json(only: [:id, :title])
  end
end
