class Web::ArticlesController < Web::ApplicationController
  def show
    @article = Article.find(params[:id]).decorate
  end
end
