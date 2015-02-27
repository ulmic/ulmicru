class Web::OmniauthController < Web::ApplicationController
  def callback
    omniauth_hash = request.env['omniauth.auth']
    user = User.find_by_email omniauth_hash['info']['email']
    if user.present?
      sign_in user
      auth = Authentication.where(user_id: user.id, provider: omniauth_hash['provider']).first
      unless auth
        Authentication.create user_id: user.id, provider: omniauth_hash['provider'], uid: omniauth_hash['uid']
      end
    else
      user = User.new email: omniauth_hash['info']['email'], first_name: omniauth_hash['info']['first_name'], last_name: omniauth_hash['info']['last_name']
      if user.save
        Authentication.create user_id: user.id, provider: omniauth_hash['provider'], uid: omniauth_hash['uid']
        sign_in user
      end
    end
    redirect_to root_path
  end

  alias :google :callback
end
