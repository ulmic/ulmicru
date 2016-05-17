class Files::ImagesController < Files::ApplicationController
  def show
    image = Image.find params[:slug]
    send_file image.image.url
  end
end
