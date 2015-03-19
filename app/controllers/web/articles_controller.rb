class Web::ArticlesController < ApplicationController
  def show
    @article = ArticleDecorator.decorate Article.find params[:id]
  end
end
