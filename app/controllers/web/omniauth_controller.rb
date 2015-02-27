class Web::OmniauthController < Web::ApplicationController
  def callback
    omniauth_hash = request.env['omniauth.auth']
    provider = omniauth_hash['provider']
    email = omniauth_hash['info']['email']
    uid = omniauth_hash['uid']
    first_name = omniauth_hash['info']['first_name']
    last_name = omniauth_hash['info']['last_name']

    authentication = Authentication.where(provider: provider, uid: uid).first
    if authentication.present?
      sign_in authentication.user
    else
      unless signed_in?
        user = User.create email: email, first_name: first_name, last_name: last_name
        sign_in user
      end
      Authentication.create user_id: current_user.id, provider: provider, uid: uid
    end
    redirect_to root_path
  end

  alias :google :callback
  alias :vkontakte :callback
end
