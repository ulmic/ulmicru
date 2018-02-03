class Api::Export::UsersController < Api::Export::ApplicationController
  def index
    users = User.all
    render json: users,
           each_serializer: UserPresenter,
           status: :ok
  end
end
