class Web::Admin::LoggedActionsController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts

  def index
    if params[:search]
      logged_actions = LoggedAction.search_everywhere params[:search]
    else
      logged_actions = LoggedAction.all
    end
    @logged_actions = logged_actions.order('created_at DESC').page(params[:page]).decorate
  end

  def show
    @logged_action = LoggedAction.find(params[:id]).decorate
  end
end
