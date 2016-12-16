class Api::Oauth::UsersController < Api::Oauth::ApplicationController
  respond_to :json

  def show
    respond_with current_resource_owner
  end

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
