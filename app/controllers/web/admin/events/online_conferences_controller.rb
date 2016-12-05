class Web::Admin::Events::OnlineConferencesController < Web::Admin::Events::ApplicationController
  def index
    if params[:search]
      online_conferences = ::Events::OnlineConference.presented.search_everywhere params[:search]
    else
      online_conferences = ::Events::OnlineConference.send params[:scope]
    end
    @online_conferences = online_conferences.page(params[:page]).decorate
  end

  def new
    @online_conference_form = ::Events::OnlineConferenceForm.new_with_model
  end

  def edit
    @online_conference_form = ::Events::OnlineConferenceForm.find_with_model params[:id]
  end

  def create
    @online_conference_form = ::Events::OnlineConferenceForm.new_with_model
    @online_conference_form.submit(params[:online_conference])
    if @online_conference_form.save
      redirect_to admin_online_conferences_path
    else
      render action: :new
    end
  end

  def update
    @online_conference_form = ::Events::OnlineConferenceForm.find_with_model params[:id]
    @online_conference_form.submit(params[:online_conference])
    if @online_conference_form.save
      redirect_to edit_admin_online_conference_path @online_conference_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @online_conference = ::Events::OnlineConference.find params[:id]
    @online_conference.remove
    redirect_to admin_online_conferences_path
  end
end
