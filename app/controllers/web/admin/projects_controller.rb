class Web::Admin::ProjectsController < Web::Admin::ApplicationController
  def index
    if params[:search]
      projects = Project.active.search_everywhere params[:search]
    else
      projects = Project.send params[:scope]
    end
    @projects = projects.page(params[:page]).decorate
  end

  def new
    @project_form = ProjectForm.new_with_model
  end

  def show
    @project = Project.find params[:id]
  end

  def edit
    @project_form = ProjectForm.find_with_model params[:id]
  end

  def create
    #FIXME try to add to form
    params[:project][:document_id] = Document.create!(file: params[:project][:document], title: params[:project][:title]).id
    @project_form = ProjectForm.new_with_model
    if @project_form.submit params[:project]
      redirect_to admin_projects_path
    else
      choose_teams
      render action: :new
    end
  end

  def update
    @project_form = ProjectForm.find_with_model params[:id]
    @project_form.submit(params[:project])
    if @project_form.save
      redirect_to admin_projects_path
    else
      choose_teams
      render action: :edit
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.remove
    redirect_to admin_projects_path
  end
end
