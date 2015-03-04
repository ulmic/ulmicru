class Web::NewsController < Web::ApplicationController
  def index
    @news = Web::NewsDecorator.decorate_collection News.published.order('created_at DESC')
  end

  def show
    @news = News.find(params[:id]).decorate #FIXME I'm don't know how to include decorate there into code
    if !@news.is_published?
      #FIXME there 404 error path
    end
  end
end
