class Files::ImagesController < Files::ApplicationController
  def show
    image = Image.find_by_slug params[:slug]
    redirect_to image.file
  end
end
