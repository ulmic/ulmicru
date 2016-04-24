class Rss::ApplicationController < ApplicationController
  before_filter :set_rss_format

  private

  def set_rss_format
    request.format = :xml
  end
end
