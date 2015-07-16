class Rss::NewsController < Rss::ApplicationController
  def index
    @news = News.published.page params[:page]
  end
end
