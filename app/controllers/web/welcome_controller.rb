class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.published.main
    @text_news = NewsDecorator.decorate_collection News.published.first 5
    @members = MemberDecorator.decorate_collection Member.includes(:confessions, :merits).confirmed.shuffle.first 14
    @events = ::EventDecorator.decorate_collection ::Event.includes(:activity_line).confirmed.near_future.first 8
    @banner = Banner.with_horizontal.active.actual.last
    @departaments = Team::Departament.active.order('created_at ASC')
  end
end
