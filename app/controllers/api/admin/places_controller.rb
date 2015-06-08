class Api::Admin::PlacesController < Api::Admin::ApplicationController
  include Places

  # FIXME refactor this SHIT!
  def index
    @client ||= FoursquareHelper::FoursquareClient.new
    venues = @client.search_venues_by_name(params[:place])[:venues]
    venues.sort_by! { |v| v[:stats][:checkinsCount] }
    venues.reverse!
    info = []
    venues.each do |v|
      info << { id: v.id, name: v.name, city: v.location.city }
    end
    render json: info
  end

  def create
    @place = Place.new params[:place]
    if @place.save
      head :ok
    else
      head :bad_request
    end
  end
end
