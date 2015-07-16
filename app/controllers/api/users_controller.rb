class Api::UsersController < Api::ApplicationController
  def confirm
    user = User.find_by! params.permit(:id, :token).to_hash
    user.confirm
    sign_in user
    redirect_to root_path
  end

  def resent_email_instructions
    user = User.find_by! params.permit(:id, :token).to_hash
    user.generate_token
    user.save!
    send_notification user, user, :after_create
    redirect_to account_path
  rescue
   head :bad_request
  end
end
