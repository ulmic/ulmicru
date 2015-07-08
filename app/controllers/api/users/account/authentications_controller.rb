class Api::Users::Account::AuthenticationsController < Api::ApplicationController
  def update
    @authentication_form = AuthenticationForm.find_with_model params[:id]
    @authentication_form.submit params[:authentication]
    if @authentication.save
      head :ok
    else
      head :bad_request
    end
  end
end
