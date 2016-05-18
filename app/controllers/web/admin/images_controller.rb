class Web::Admin::ImagesController < Web::Admin::ApplicationController
  before_filter :choose_users, only: [ :new, :edit ]

  def index
    if params[:search]
      images = Image.active.search_everywhere params[:search]
    else
      images = Image.send params[:scope]
    end
    @images = images.page(params[:page]).decorate
  end

  def new
    @image_form = ImageForm.new_with_model
  end

  def edit
    @image_form = ImageForm.find_with_model params[:id]
  end

  def create
    @image_form = ImageForm.new_with_model
    @image_form.submit(params[:image])
    if @image_form.save
      redirect_to admin_images_path
    else
      choose_users
      render action: :new
    end
  end

  def update
    @image_form = ImageForm.find_with_model params[:id]
    @image_form.submit(params[:image])
    if @image_form.save
      redirect_to admin_image_path @image_form.model
    else
      choose_users
      render action: :edit
    end
  end

  def destroy
    @image = Image.find params[:id]
    @image.remove
    redirect_to admin_images_path
  end
end
