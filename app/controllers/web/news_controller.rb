class Web::NewsController < Web::ApplicationController
  def index
    @news = News.published.decorate
  end

  def show
    @news = News.find(params[:id]).decorate
    unless @news.is_published?
      #FIXME there 404 error path
    end
    @activity_lines = @news.tags.activity_lines
    @events = @news.tags.events
    @teams = @news.tags.teams
    topic_news_tags = @news.tags.last 2
    @topic_news = []
    topic_news_tags.each do |tag|
      news_tag = Tag.where(target_type: tag.target_type, record_type: 'News').where("record_id != #{@news.id}").last
      @topic_news << NewsDecorator.decorate(news_tag.record) if news_tag
    end
    @last_news = NewsDecorator.decorate_collection News.published.first 3
    @members = @news.tags.members.map &:target
    @strings = @news.tags.string
    @not_strings = @news.tags.events + @news.tags.activity_lines + @news.tags.teams
    @news.increase_views
    @previous_news = News.published.previous @news.id
    @next_news = News.published.next @news.id
    @same_events = ::EventDecorator.decorate_collection same_events
    @popular_news = NewsDecorator.decorate_collection News.popular.first 6
  end

  private

  def same_events
    activity_line = @news.tags.activity_lines.map(&:target).first
    source = activity_line ? activity_line.events : ::Event
    source.confirmed.near_future.first 3
  end
end
