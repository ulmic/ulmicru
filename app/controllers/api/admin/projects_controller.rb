class Api::Admin::ProjectsController < Api::Admin::ApplicationController
  def index
    projects = if params[:q].present?
                 ::Project.search_everywhere params[:q][:term]
               else
                 ::Project.all
               end
    render json: projects.to_json(only: [:id, :title])
  end
end
