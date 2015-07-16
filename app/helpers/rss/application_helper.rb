module Rss::ApplicationHelper
  def next_page
    params[:page].present? ? page = params[:page].to_i + 1 : page = 2
    send "#{params[:controller].gsub('/', '_')}_index_url", page: page
  end
end
