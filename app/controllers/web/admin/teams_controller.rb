class Web::Admin::TeamsController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]
  before_filter :choose_departaments, only: [ :new, :edit ]

  def index
    @teams = {}
    @teams[:active] = Team.active.page(params[:page]).decorate
    @teams[:unviewed] = Team.unviewed.page(params[:page]).decorate
    @teams[:removed] = Team.removed.page(params[:page]).decorate
    @teams[:search] = Team.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
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
      choose_departaments
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
    [:team_departament, :team_subdivision, :team_administration, :team_primary].each do |type|
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
      choose_departaments
      render action: :edit
    end
  end

  def destroy
    @team = Team.find params[:id]
    @team.remove
    redirect_to admin_teams_path
  end

  private

  def choose_departaments
    @departaments = TeamDecorator.decorate_collection Team::Departament.active
  end
end
