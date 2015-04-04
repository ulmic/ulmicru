class Web::Admin::TeamsController < Web::Admin::ApplicationController
  def index
    @teams = Team.active
  end

  def new
    @team_form = TeamForm.new_with_model
    @categories = Category.presented.decorate
  end

  def create
    @team_form = TeamForm.new_with_model
    @team_form.submit params[:team]
    if @team_form.save
      redirect_to admin_teams_path
    else
      @categories = Category.presented.decorate
      render action: :new
    end
  end

  def edit
    @team_form = TeamForm.find_with_model params[:id]
    @categories = Category.presented.decorate
  end

  def update
    @team_form = TeamForm.find_with_model params[:id]
    @team_form.submit params[:team]
    if @team_form.save
      redirect_to admin_teams_path
    else
      render action: :edit
    end
  end

  def destroy
    @team = Team.find params[:id]
    @team.remove
    redirect_to admin_teams_path
  end
end
