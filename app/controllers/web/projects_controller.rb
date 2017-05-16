class Web::ProjectsController < Web::ApplicationController
  def show
    @project = Project.find params[:id]
    render layout: false
  end
end
