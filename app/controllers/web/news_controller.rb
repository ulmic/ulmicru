class Web::NewsController < Web::ApplicationController
  def index
    @news = News.published.decorate
    @activity_line = ActivityLineDecorator.decorate @news.tags.activity_lines.first.target
  end

  def show
    @news = News.find(params[:id]).decorate
    if !@news.is_published?
      #FIXME there 404 error path
    end
  end
end
