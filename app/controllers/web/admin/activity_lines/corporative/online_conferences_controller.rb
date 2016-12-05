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
    @activity_lines_corporative_online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.new_with_model
  end

  def edit
    @activity_lines_corporative_online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.find_with_model params[:id]
  end

  def create
    @activity_lines_corporative_online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.new_with_model
    @activity_lines_corporative_online_conference_form.submit params[:activity_lines_corporative_online_conference]
    if @activity_lines_corporative_online_conference_form.save
      redirect_to admin_activity_lines_corporative_online_conferences_path
    else
      render action: :new
    end
  end

  def update
    @activity_lines_corporative_online_conference_form = ::ActivityLines::Corporative::OnlineConferenceForm.find_with_model params[:id]
    @activity_lines_corporative_online_conference_form.submit params[:activity_lines_corporative_online_conference]
    if @activity_lines_corporative_online_conference_form.save
      redirect_to edit_admin_activity_lines_corporative_online_conference_path @activity_lines_corporative_online_conference_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @activity_lines_corporative_online_conference = ::ActivityLines::Corporative::OnlineConference.find params[:id]
    @activity_lines_corporative_online_conference.remove
    redirect_to admin_activity_lines_corporative_online_conferences_path
  end
end
