class Api::UsersController < Api::ApplicationController
  def confirm
    user = User.find_by! params.extract(:id, :token).to_hash
    user.confirm
    sign_in user
    redirect_to root_path
  end
end
