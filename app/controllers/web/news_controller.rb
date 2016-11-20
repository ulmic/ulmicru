class Web::NewsController < Web::ApplicationController
  before_filter :add_comment, only: :show

  def index
    @news = News.published.decorate
  end

  def show
    @news = News.find(params[:id]).decorate
    unless @news.is_published?
      redirect_to not_found_page_path
    end
    topic_news_tags = @news.tags
    topic_news = []
    topic_news_tags.each do |tag|
      news_tag = Tag.active.where(target_type: tag.target_type, record_type: 'News').where.not(record_id: @news.id).where.not(record_id: topic_news.map(&:id)).last
      topic_news << NewsDecorator.decorate(news_tag.record) if news_tag && news_tag.record.is_published?
    end
    @topic_news = topic_news.last 2
    @last_news = NewsDecorator.decorate_collection News.published.first 3
    @members = @news.tags.active.members.map &:target
    @strings = @news.tags.active.string
    @not_strings = @news.tags.active.events + @news.tags.active.activity_lines + @news.tags.active.teams
    @news.increase_views
    @previous_news = News.previous @news.id, on: :published
    @next_news = News.next @news.id, on: :published
    @same_events = ::EventDecorator.decorate_collection same_events
    @popular_news = NewsDecorator.decorate_collection News.popular.first 6
    @banner = Banner.active.with_vertical.actual.last
  end

  private

  def same_events
    activity_line = @news.tags.activity_lines.map(&:target).first
    source = activity_line ? activity_line.events : ::Event
    source.confirmed.near_future.first 3
  end
end
