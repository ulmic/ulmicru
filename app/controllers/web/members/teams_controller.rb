class Web::Members::TeamsController < Web::Members::ApplicationController
  before_filter :authenticate_team_header!
  before_filter :edit_params, only: :update
  before_filter :set_team
  before_filter :choose_teammates, only: :edit

  def edit
    @team_form = TeamForm.find_with_model params[:id]
  end

  def update
    @team_form = TeamForm.find_with_model params[:id]
    if @team_form.submit params[:team]
      redirect_to edit_members_team_path @team_form.model
    else
      choose_teammates
      render :edit
    end
  end

  private

  def authenticate_team_header!
    team = Team.find params[:id]
    redirect_to not_found_page_path unless current_user.id == team.member_id
    return
  end

  def set_team
    @team = Team.includes(:users).find(params[:id]).decorate
  end
end
