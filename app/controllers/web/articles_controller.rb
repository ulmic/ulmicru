class Web::ArticlesController < ApplicationController
  def index

  end

  def show
    @article = ArticleDecorator.decorate Article.find params[:id]
  end
end
