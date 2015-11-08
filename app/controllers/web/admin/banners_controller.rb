class Web::Admin::BannersController < Web::Admin::ApplicationController
  def index
    @banners = {}
    @banners[:actual] = Banner.actual.page(params[:page]).decorate
    @banners[:active] = Banner.active.page(params[:page]).decorate
    @banners[:unviewed] = Banner.unviewed.page(params[:page]).decorate
    @banners[:removed] = Banner.removed.page(params[:page]).decorate
    @banners[:search] = Banner.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
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
      redirect_to edit_admin_banner_path @banner_form.model
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
