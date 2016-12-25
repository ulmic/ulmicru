class Web::Admin::ActivityLines::Corporative::OnlineConferencesController < 
      Web::Admin::ActivityLines::Corporative::ApplicationController
  def index
    if params[:search]
      online_conferences = ::ActivityLines::Corporative::OnlineConference.active.search_everywhere params[:search]
    else
      online_conferences = ::ActivityLines::Corporative::OnlineConference.send params[:scope]
    end
    @activity_lines_corporative_online_conferences = online_conferences.page(params[:page]).decorate
  end

  def show
    @online_conference = ::ActivityLines::Corporative::OnlineConference.find(params[:id]).decorate
  end

  def new
    @online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.new_with_model
  end

  def edit
    @online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.find_with_model params[:id]
  end

  def create
    @online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.new_with_model
    @online_conference_form.submit params[:activity_lines_corporative_online_conference]
    if @online_conference_form.save
      redirect_to new_admin_event_path event: build_event
    else
      render action: :new
    end
  end

  def update
    @online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.find_with_model params[:id]
    @online_conference_form.submit params[:activity_lines_corporative_online_conference]
    if @online_conference_form.save
      redirect_to admin_activity_lines_corporative_online_conference_path @online_conference_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @online_conference = ::ActivityLines::Corporative::OnlineConference.find params[:id]
    @online_conference.remove
    redirect_to admin_activity_lines_corporative_online_conferences_path
  end

  private

  def build_event
    { title: @online_conference_form.model.decorate.event_title,
      begin_date: @online_conference_form.model.date,
      end_date: @online_conference_form.model.date + 3.hours,
      creator_id: current_user.id }
  end
end
