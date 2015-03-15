class Web::Admin::ArticleController < ApplicationController
  def index
    @articles = ArticleDecorator.decorate_collection Article.all
  end

  def new

  end
end
