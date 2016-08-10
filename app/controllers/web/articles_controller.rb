class Web::ArticlesController < Web::ApplicationController
  before_filter :add_comment, only: :show

  def show
    @article = Article.find(params[:id]).decorate
    if @article.access.members?
      authenticate_member!
      return
    end
    @article.increase_views
    @topic_articles = Article.broadcasted.same_articles(@article).last 3
    @strings = @article.tags.active.string
    @not_strings = @article.tags.active.events + @article.tags.active.activity_lines + @article.tags.active.teams
    @members = @article.tags.active.members.map &:target
    @popular_articles = ArticleDecorator.decorate_collection Article.broadcasted.popular.first 3
  end
end
