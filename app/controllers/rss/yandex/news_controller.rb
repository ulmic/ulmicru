class Rss::Yandex::NewsController < Rss::Yandex::ApplicationController
  def index
    @news = News.published.page params[:page]
  end
end
