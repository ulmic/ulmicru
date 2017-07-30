class Web::WelcomeController < Web::ApplicationController
  def index
    @news = News.published.main
    @text_news = NewsDecorator.decorate_collection News.published.first 5
    @members = MemberDecorator.decorate_collection Member.includes(:confessions, :merits).confirmed.shuffle.first 14
    events = ::EventDecorator.decorate_collection ::Event.includes(:activity_line, :organizer).confirmed.near_future
    @mic_events = events.map do |event|
      event if event.organizer_type != 'Team' || event.organizer.is_ulmic_team?
    end.compact.first 8
    @not_mic_events = Team::AnotherTeam.active.reduce({}) do |hash, team|
      if team.events.confirmed.any?
        hash.merge! team.title => team.events.confirmed.first(8)
      end
    end
    @banner = Banner.with_horizontal.active.actual.last
    @departaments = Team::Departament.active.order('created_at ASC')
  end
end
