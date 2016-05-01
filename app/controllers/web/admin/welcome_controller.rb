class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  before_filter :redirect_to_unviewed

  def index
  end

  private

  def redirect_to_unviewed
    redirect_to admin_unviewed_index_path unless @notification_count == 0
  end
end
