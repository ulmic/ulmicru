class Api::YoficationsController < Api::ApplicationController
  include Karamzin

  def create
    @yofication = Functional::YoficationForm.new_with_model
    body = params[:yofication][:body].clone
    params[:yofication][:yoficated_body] = insert body
    if @yofication.submit params[:yofication]
      render json: { yoficated_body: @yofication.yoficated_body }
    else
      head :bad_request
    end
  end
end
