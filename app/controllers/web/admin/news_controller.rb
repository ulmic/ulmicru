class Web::Admin::NewsController < Web::Admin::ApplicationController
  def index
    @published_news = Web::NewsDecorator.decorate_collection News.published.order('created_at DESC')
    @unpublished_news = Web::NewsDecorator.decorate_collection News.published.order('created_at DESC')
  end

  def show
    @news = News.find(params[:id]).decorate #FIXME I'm don't know how to include decorate there into code
    if !@news.is_published?
      #FIXME there 404 error path
    end
  end

  def create

  end

  def new
    
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
