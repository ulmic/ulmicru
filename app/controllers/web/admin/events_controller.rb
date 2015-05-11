class Web::Admin::EventsController < Web::Admin::ApplicationController
  def index
    events = ::Event.presented
    @future_events = events.future.decorate
    @current_events = events.current.decorate
    @past_events = events.past.decorate
    @unviewed_events = ::Event.unviewed.decorate
    @declined_events = ::Event.declined.decorate
  end

  def new
    @event_form = EventForm.new_with_model
    @members = Member.presented.decorate
    @teams = Team.active.decorate
  end

  def edit
    @event_form = EventForm.find_with_model(params[:id])
    @members = Member.presented.decorate
    @teams = Team.active.decorate
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
