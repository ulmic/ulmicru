class Files::ImagesController < Files::ApplicationController
  def show
    image = Image.find_by_slug params[:slug]
    redirect_to request.env['HTTP_HOST'] + image.file.url
  end
end
