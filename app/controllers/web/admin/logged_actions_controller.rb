class Web::Admin::LoggedActionsController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts

  def index
    @logged_actions = LoggedAction.all.page(params[:page]).decorate
  end
end
