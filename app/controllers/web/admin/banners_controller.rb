class Web::Admin::BannersController < Web::Admin::ApplicationController
  def index
    @banners = Banner.all
  end

  def new
    @banner = Banner.new
    @banner_form = BannerForm.new(@banner)
  end

  def edit
    @banner = Banner.find params[:id]
    @banner_form = BannerForm.new(@banner)
  end

  def create
    @banner = Banner.new
    @banner_form = BannerForm.new(@banner)
    @banner_form.submit(params[:banner])
    if @banner_form.save
      redirect_to admin_banners_path
    else
      render action: :new
    end
  end

  def update
    @banner = Banner.find params[:id]
    @banner_form = BannerForm.new(@banner)
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
