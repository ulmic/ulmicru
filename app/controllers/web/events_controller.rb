class Web::EventsController < Web::ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create ]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @event_form = EventForm.new @event
  end

  def create
    @event = Event.new
    @event_form = EventForm.new @event
    @event_form.submit params[:event]
    if @event_form.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def show
    @event = Event.find params[:id]
  end
end
