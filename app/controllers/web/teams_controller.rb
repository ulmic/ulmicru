class Web::TeamsController < Web::ApplicationController
  def show
    team = Team.find(params[:id])
    @team = team.decorate
    @members = team.users.decorate
    @owner = team.member.decorate
    @events = ::EventDecorator.decorate_collection @team.events
    @news = NewsDecorator.decorate_collection team.tags.active.news.map &:record
    @articles = team.tags.active.articles.map &:record
  end
end
