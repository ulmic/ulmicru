class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.published.last 5
    @text_news = NewsDecorator.decorate_collection News.published.last 20
  end
end
