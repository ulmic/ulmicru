class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  def index
  end
end
