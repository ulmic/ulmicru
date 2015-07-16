class Rss::ContentController < Rss::ApplicationController
  def index
    articles = Article.broadcasted.decorate
    news = News.published
    @content = Kaminari.paginate_array (articles + news).sort_by{ |post| post.created_at }
  end
end
