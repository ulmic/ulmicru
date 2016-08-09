class Web::Members::TeamsController < Web::Members::ApplicationController
  before_filter :authenticate_team_header!
  before_filter :edit_params, only: :update

  def edit
    @team = Team.includes(users: :positions).find(params[:id]).decorate
    @team_form = TeamForm.find_with_model params[:id]
  end

  def update
    @team = TeamForm.find_with_model params[:id]
    if @team.submit params[:team]
      redirect_to edit_members_team_path @team.model
    else
      render :edit
    end
  end

  private

  def authenticate_team_header!
    team = Team.find params[:id]
    redirect_to not_found_page_path unless current_user.id == team.member_id
    return
  end
end
