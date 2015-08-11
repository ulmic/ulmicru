class Web::Admin::TeamsController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    @teams = {}
    @teams[:active] = Kaminari.paginate_array(Team.active.decorate).page params[:page]
    @teams[:unviewed] = Kaminari.paginate_array(Team.unviewed.decorate).page params[:page]
    @teams[:removed] = Kaminari.paginate_array(Team.removed.decorate).page params[:page]
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
      choose_members
      @categories = Category.presented.decorate
      render action: :new
    end
  end

  def edit
    @team_form = TeamForm.find_with_model params[:id]
    @categories = Category.presented.decorate
  end

  def update
    #FIXME refactoring
    [:team_departament, :team_subdivision, :team_administration].each do |type|
      if params[type]
        params[:team] = params[type]
        break
      end
    end
    @team_form = TeamForm.find_with_model params[:id]
    @team_form.submit params[:team]
    if @team_form.save
      redirect_to edit_admin_team_path @team_form.model
    else
      choose_members
      render action: :edit
    end
  end

  def destroy
    @team = Team.find params[:id]
    @team.remove
    redirect_to admin_teams_path
  end
end
