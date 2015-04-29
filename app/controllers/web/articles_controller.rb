class Web::ArticlesController < Web::ApplicationController
  def show
    @article = Article.find(params[:id]).decorate
    @members = @article.tags.members.map &:target
    @strings = @article.tags.string
    @article.increase_views
  end
end
