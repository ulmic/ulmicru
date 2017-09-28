class Web::Admin::ActivityLines::It::ItWaysController < Web::Admin::ActivityLines::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts

  def index
    @requests = Project.find(1).records
  end
end
