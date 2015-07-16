class Rss::ArticlesController < Rss::ApplicationController
  def index
    @articles = Article.broadcasted.decorate
  end
end
