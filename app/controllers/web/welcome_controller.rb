class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.published.main
    @text_news = NewsDecorator.decorate_collection News.published.first 5
    @members = MemberDecorator.decorate_collection Member.confirmed.shuffle.first 14
    @events = ::EventDecorator.decorate_collection ::Event.active.near_future.order('end_date DESC').first 8
  end
end
