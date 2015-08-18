class Web::Admin::EventsController < Web::Admin::ApplicationController
  before_filter :choose_teams, only: [ :new, :edit ]
  before_filter :choose_users, only: [ :new, :edit ]
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    @events = {}
    @events[:future] = Kaminari.paginate_array(::Event.presented.future.decorate).page params[:page]
    @events[:current] = Kaminari.paginate_array(::Event.presented.current.decorate).page params[:page]
    @events[:past] = Kaminari.paginate_array(::Event.presented.past.decorate).page params[:page]
    @events[:unviewed] = Kaminari.paginate_array(::Event.unviewed.decorate).page params[:page]
    @events[:declined] = Kaminari.paginate_array(::Event.declined.decorate).page params[:page]
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
      choose_users
      choose_members
      render action: :new
    end
  end

  def update
    @event_form = EventForm.find_with_model params[:id]
    @event_form.submit(params[:event])
    if @event_form.save
      redirect_to edit_admin_event_path @event_form.model
    else
      choose_teams
      choose_users
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
