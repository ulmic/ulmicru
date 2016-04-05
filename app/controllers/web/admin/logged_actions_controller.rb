class Web::Admin::LoggedActionsController < Web::Admin::ApplicationController
  def index
    @logged_actions = LoggedAction.all.page(params[:page]).decorate
  end
end
