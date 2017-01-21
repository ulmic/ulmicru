class Web::Admin::PlacesController < Web::Admin::ApplicationController
  def index
    if params[:search]
      places = Place.presented.search_everywhere params[:search]
    else
      places = Place.send params[:scope]
    end
    @places = places.page(params[:page]).decorate
  end

  def new
    @place_form = PlaceForm.new_with_model
  end

  def show
    @place = Place.find(params[:id]).decorate
  end

  def edit
    @place_form = PlaceForm.find_with_model params[:id]
  end

  def create
    @place_form = PlaceForm.new_with_model
    @place_form.submit(params[:place])
    if @place_form.save
      redirect_to admin_places_path
    else
      render action: :new
    end
  end

  def update
    @place_form = PlaceForm.find_with_model params[:id]
    @place_form.submit(params[:place])
    if @place_form.save
      redirect_to admin_places_path
    else
      render action: :edit
    end
  end

  def destroy
    @place = Place.find params[:id]
    @place.remove
    redirect_to admin_places_path
  end
end
