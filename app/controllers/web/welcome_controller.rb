class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.published.last 5
    @text_news = NewsDecorator.decorate_collection News.published.last 20
    @members = MemberDecorator.decorate_collection Member.confirmed.shuffle.first 14
    @events = ::EventDecorator.decorate_collection(::Event.current + ::Event.future).first 8
  end
end
