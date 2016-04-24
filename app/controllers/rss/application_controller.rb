class Rss::ApplicationController < ApplicationController
  before_filter :set_rss_format
  skip_before_filter :errors_view

  private

  def set_rss_format
    request.format = :xml
  end
end
