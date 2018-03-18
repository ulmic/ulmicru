class Api::Export::PlacesController < Api::Export::ApplicationController
  def index
    places = Place.all
    render json: places,
           each_serializer: ::PlacePresenter,
           status: :ok
  end
end
