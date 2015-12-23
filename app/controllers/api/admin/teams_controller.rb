class Api::Admin::TeamsController < Api::Admin::ApplicationController
  def index
    if params[:q].present?
      @teams = Team.active.search_everywhere params[:q][:term]
    else
      @teams = Team.active
    end
    render json: @teams.to_json(only: [:id, :title])
  end
end
