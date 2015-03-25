class Web::Admin::EventsController < Web::ApplicationController
  def index
    @events = Event.presented
  end

  def new
    @event_form = EventForm.new_with_model
  end

  def edit
    @event_form = EventForm.find_with_model(params[:id])
  end

  def create
    @event_form = EventForm.new_with_model
    @event_form.submit(params[:event])
    if @event_form.save
      redirect_to admin_events_path
    else
      render action: :new
    end
  end

  def update
    @event_form = EventForm.find_with_model params[:id]
    @event_form.submit(params[:event])
    if @event_form.save
      redirect_to admin_events_path
    else
      render action: :edit
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.remove
    redirect_to admin_events_path
  end
end
