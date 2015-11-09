class Rss::Yandex::NewsController < Rss::Yandex::ApplicationController
  def index
    @news = News.published.actual.page(params[:page]).decorate
  end
end
