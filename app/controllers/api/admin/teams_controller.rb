class Api::Admin::TeamsController < Api::Admin::ApplicationController
  def index
    @teams = Team.active
    render json: { model: 'Team', list: @teams.to_json(only: [:id, :title]) }
  end
end
