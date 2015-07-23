class Web::Admin::EventsController < Web::Admin::ApplicationController
  before_filter :choose_teams, only: [ :new, :edit ]
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    events = ::Event.presented
    @future_events = Kaminari.paginate_array(events.future.decorate).page params[:page]
    @current_events = Kaminari.paginate_array(events.current.decorate).page params[:page]
    @past_events = Kaminari.paginate_array(events.past.decorate).page params[:page]
    @unviewed_events = Kaminari.paginate_array(::Event.unviewed.decorate).page params[:page]
    @declined_events = Kaminari.paginate_array(::Event.declined.decorate).page params[:page]
  end

  def new
    @event_form = EventForm.new_with_model
  end

  def edit
    @event_form = EventForm.find_with_model(params[:id])
  end

  def create
    @event_form = EventForm.new_with_model
    @event_form.submit params[:event]
    if @event_form.save
      redirect_to admin_events_path
    else
      choose_teams
      choose_members
      render action: :new
    end
  end

  def update
    @event_form = EventForm.find_with_model params[:id]
    @event_form.submit(params[:event])
    if @event_form.save
      redirect_to admin_events_path
    else
      choose_teams
      choose_members
      render action: :edit
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.remove
    redirect_to admin_events_path
  end
end
