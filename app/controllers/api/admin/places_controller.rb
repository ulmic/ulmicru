class Api::Admin::PlacesController < Api::Admin::ApplicationController
  skip_before_filter :authenticate_admin!
  before_filter :authenticate_permitted_create_place!

  def create
    @place = Place.new_with_model
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
