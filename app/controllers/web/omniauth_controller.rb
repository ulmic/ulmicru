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
      sign_in authentication.user
    else
      unless signed_in?
        user = User.find_by_email email if email
        if user
          Authentication.create user_id: user.id, provider: provider, uid: uid
        else
          password = SecureRandom.hex 8
          user = User.new email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password
          user.authentications.build provider: provider, uid: uid
          user.save
        end
        sign_in user
        redirect_to account_path
        return
      end
      Authentication.create user_id: current_user.id, provider: provider, uid: uid
    end
    redirect_to account_path
  end

  alias :google :callback
  alias :vkontakte :callback
  alias :twitter :callback
  alias :facebook :callback
end
