class Api::Users::PlacesController < Api::Users::ApplicationController
  def index
    if params[:q].present?
      places = Place.presented.search_everywhere params[:q][:term]
      render json: places.to_json(only: [:id, :title])
    end
  end

  def create
    @place = PlaceForm.new_with_model
    if @place.submit params[:place]
      render json: { id: @place.model.id, title: @place.model.title }
    else
      head :bad_request
    end
  end
end
