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
      redirect_to admin_activity_lines_corporative_online_conferences_path
    else
      render action: :new
    end
  end

  def update
    @online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.find_with_model params[:id]
    @online_conference_form.submit params[:activity_lines_corporative_online_conference]
    if @online_conference_form.save
      redirect_to admin_activity_lines_corporative_online_conferences_path
    else
      render action: :edit
    end
  end

  def destroy
    @online_conference = ::ActivityLines::Corporative::OnlineConference.find params[:id]
    @online_conference.remove
    redirect_to admin_activity_lines_corporative_online_conferences_path
  end
end
