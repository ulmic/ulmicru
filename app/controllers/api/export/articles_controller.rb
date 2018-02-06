class Api::Export::ArticlesController < Api::Export::ApplicationController
  def index
    articles = Article.all
    render json: articles,
           each_serializer: ArticlePresenter,
           status: :ok
  end
end
