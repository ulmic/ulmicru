class Api::Export::TeamsController < Api::Export::ApplicationController
  def index
    teams = Team.all
    render json: teams,
           each_serializer: TeamPresenter,
           includes: [ :users ],
           status: :ok
  end
end
