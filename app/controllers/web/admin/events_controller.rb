class Web::Admin::EventsController < Web::Admin::ApplicationController
  before_filter :choose_teams, only: [ :new, :edit ]
  before_filter :choose_users, only: [ :new, :edit ]
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    if params[:search]
      events = ::Event.presented.search_everywhere params[:search]
    else
      events = ::Event.send params[:scope]
    end
    @events = events.page(params[:page]).decorate
  end

  def new
    @event_form = pre_build_record EventForm.new_with_model
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
