class Api::Admin::PlacesController < Api::Admin::ApplicationController
  def create
    @place = Place.new_with_model
    if @place.submit params[:place]
      head :ok
    else
      head :bad_request
    end
  end
end
