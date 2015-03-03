class Web::NewsController < Web::ApplicationController
  def index
    @news = NewsDecorator.decorate_collection News.published.order('created_at DESC')
  end

  def show
    @news = News.find(params[:id]).decorate
    if !@news.is_published?
#FIXME there 404 error path
    end
  end
end
