class Web::EventsController < Web::ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id]).decorate
  end
end
