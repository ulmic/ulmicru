class Web::Admin::Oauth::AppsController < Web::Admin::ApplicationController
  def index
    if params[:search]
      apps = Oauth::App.active.search_everywhere params[:search]
    else
      apps = Oauth::App.send params[:scope]
    end
    @apps = apps.page(params[:page]).decorate
  end

  def new
    @app_form = Oauth::AppForm.new_with_model
    @app_form.model.client_id = (Oauth::App.order(:client_id).last&.client_id&.to_i || 0) + 1
  end

  def edit
    @app_form = Oauth::AppForm.find_with_model params[:id]
  end

  def create
    @app_form = Oauth::AppForm.new_with_model
    @app_form.submit params[:oauth_app]
    if @app_form.save
      redirect_to admin_oauth_apps_path
    else
      render action: :new
    end
  end

  def update
    @app_form = Oauth::AppForm.find_with_model params[:id]
    @app_form.submit params[:oauth_app]
    if @app_form.save
      redirect_to admin_oauth_apps_path
    else
      render action: :edit
    end
  end

  def destroy
    @app = Oauth::App.find params[:id]
    @app.remove
    redirect_to admin_oauth_apps_path
  end
end
