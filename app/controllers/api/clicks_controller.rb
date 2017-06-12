class Api::ClicksController < Api::ApplicationController
  def create
    click = ClickForm.new_with_model
    params[:click][:user_id] = current_user&.id
    if click.submit params[:click]
      head :ok
    else
      head :bad_request
    end
  end
end
