class Web::Users::AuthenticationsController < Web::Users::ApplicationController
  def destroy
    @authentication = Authentication.find params[:id]
    @authentication.destroy
    redirect_to account_path
  end
end
