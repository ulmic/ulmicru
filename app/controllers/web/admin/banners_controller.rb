class Web::Admin::BannersController < Web::Admin::ApplicationController
  def index
    if params[:search]
      banners = Banner.presented.search_everywhere params[:search]
    else
      banners = Banner.send params[:scope]
    end
    @banners = banners.page(params[:page]).decorate
  end

  def new
    @banner_form = BannerForm.new_with_model
  end

  def edit
    @banner_form = BannerForm.find_with_model params[:id]
  end

  def create
    @banner_form = BannerForm.new_with_model
    @banner_form.submit(params[:banner])
    if @banner_form.save
      redirect_to admin_banners_path
    else
      render action: :new
    end
  end

  def update
    @banner_form = BannerForm.find_with_model params[:id]
    @banner_form.submit(params[:banner])
    if @banner_form.save
      redirect_to admin_banners_path
    else
      render action: :edit
    end
  end

  def destroy
    @banner = Banner.find params[:id]
    @banner.remove
    redirect_to admin_banners_path
  end
end
