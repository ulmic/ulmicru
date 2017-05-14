require 'securerandom'

class Web::OmniauthController < Web::ApplicationController
  def callback
    omniauth_hash = request.env['omniauth.auth']
    provider = omniauth_hash['provider']
    email = omniauth_hash['info']['email']
    uid = omniauth_hash['uid']
    if provider != 'twitter'
      first_name = omniauth_hash['info']['first_name']
      last_name = omniauth_hash['info']['last_name']
    else
      first_name = omniauth_hash['info']['name']
      last_name = ''
    end

    authentication = Authentication.where(provider: provider, uid: uid).first
    if authentication.present?
      if signed_in?
        authentication.user_id = current_user.id
        authentication.save
      else
        sign_in authentication.user
	log_action :sign_in
      end
    else
      unless signed_in?
        user = User.find_by_email email if email
        unless user
          password = SecureRandom.hex 8
          user = User.create email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password, state: :confirmed
          initialize_subscriptions user
        end
        sign_in user
	log_action :sign_in
      end
      Authentication.create user_id: current_user.id, provider: provider, uid: uid
    end
    current_user.set_gender!
    redirect_to session[:redirect_url] || account_path
  end

  alias :google :callback
  alias :vkontakte :callback
  alias :twitter :callback
  alias :facebook :callback
end
