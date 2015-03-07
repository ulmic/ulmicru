class Web::NewsController < Web::ApplicationController
  def index
    @news = NewsDecorator.decorate_collection News.published.order('published_at DESC')
  end

  def show
    @news = NewsDecorator.decorate News.find params[:id] #FIXME I'm don't know how to include decorate there into code
    if !@news.is_published?
      #FIXME there 404 error path
    end
  end
end
