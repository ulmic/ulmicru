class Web::Users::AccountController < Web::Users::ApplicationController
  def index
    @authentications = current_user.authentications
  end
end
