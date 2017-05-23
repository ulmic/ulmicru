class Web::Admin::VideosController < Web::Admin::ApplicationController
  def index
    if params[:search]
      videos = Video.active.search_everywhere params[:search]
    else 
      videos = Video.send params[:scope]
    end
    @videos = videos.order('id DESC').page(params[:page]).decorate
  end

  def new
    @video_form = VideoForm.new_with_model
  end

  def create
    @video_form = VideoForm.new_with_model

    if @video_form.submit params[:video]
      redirect_to admin_videos_path
    else
      @categories = Category.presented.decorate
      render action: :new
    end
  end

  def edit
    @video_form = VideoForm.find_with_model params[:id]
  end

  def update
    @video_form = VideoForm.find_with_model params[:id]
    if @video_form.submit params[:video]
      redirect_to edit_admin_video_path @video_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @video = Video.find params[:id]
    @video.remove
    redirect_to admin_videos_path
  end
end
