class Api::Admin::PlacesController < Api::Admin::ApplicationController
  skip_before_filter :authenticate_admin!
  before_filter :authenticate_permitted_create_place!

  def index
    if params[:q].present?
      places = Place.active.search_everywhere params[:q][:term]
      render json: places.to_json(only: [:id, :title])
    end
  end

  def create
    @place = PlaceForm.new_with_model
    if @place.submit params[:place]
      head :ok
    else
      head :bad_request
    end
  end

  private

  def authenticate_permitted_create_place!
    unless permitted_to? :create, :place
      head :not_acceptable
      return
    end
  end
end
