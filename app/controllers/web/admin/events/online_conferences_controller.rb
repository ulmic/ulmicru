class Web::Admin::Events::OnlineConferencesController < Web::Admin::Events::ApplicationController
  def index
    if params[:search]
      online_conferences = ::Events::OnlineConference.active.search_everywhere params[:search]
    else
      online_conferences = ::Events::OnlineConference.send params[:scope]
    end
    @events_online_conferences = online_conferences.page(params[:page]).decorate
  end

  def new
    @events_online_conference_form = ::Events::OnlineConferenceForm.new_with_model
  end

  def edit
    @events_online_conference_form = ::Events::OnlineConferenceForm.find_with_model params[:id]
  end

  def create
    @events_online_conference_form = ::Events::OnlineConferenceForm.new_with_model
    @events_online_conference_form.submit params[:events_online_conference]
    if @events_online_conference_form.save
      redirect_to admin_events_online_conferences_path
    else
      render action: :new
    end
  end

  def update
    @events_online_conference_form = ::Events::OnlineConferenceForm.find_with_model params[:id]
    @events_online_conference_form.submit params[:events_online_conference]
    if @events_online_conference_form.save
      redirect_to edit_admin_events_online_conference_path @events_online_conference_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @events_online_conference = ::Events::OnlineConference.find params[:id]
    @events_online_conference.remove
    redirect_to admin_events_online_conferences_path
  end
end
