class Web::Admin::TeamsController < Web::Admin::ApplicationController
  # NOTE we need it to edit params before save object
  skip_before_action :save_object, only: :update
  before_action :edit_params, only: :update
  before_action :save_object, only: :update

  before_filter :choose_members, only: [ :new, :edit ]
  before_filter :choose_departaments, only: [ :new, :edit ]

  def index
    if params[:search]
      teams = Team.presented.search_everywhere params[:search]
    else
      teams = Team.send params[:scope]
    end
    @teams = teams.page(params[:page]).decorate
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
    @team_form = TeamForm.find_with_model params[:id]
    @team_form.submit params[:team]
    if @team_form.save
      redirect_to admin_teams_path
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

  def edit_params
    #FIXME refactoring
    [:team_departament, :team_subdivision, :team_administration, :team_primary, :team_committee].each do |type|
      if params[type]
        params[:team] = params[type]
        break
      end
    end
  end
end
