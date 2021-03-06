class Web::NewsController < Web::ApplicationController
  before_filter :add_comment, only: :show

  def index
    @news = News.published.decorate
  end

  def show
    topic_news = []
    @news = News.published.find_by(id: params[:id])&.decorate
    if @news.present?
      View.create! user_id: current_user&.id, record_id: @news.id, record_type: 'News'
      topic_news_tags = @news.tags
      topic_news = []
      topic_news_tags.each do |tag|
        news_tag = Tag.active.where(target_type: tag.target_type, record_type: 'News').where.not(record_id: @news.id).where.not(record_id: topic_news.map(&:id)).last
        topic_news << NewsDecorator.decorate(news_tag.record) if news_tag && news_tag.record.is_published?
      end
      @topic_news = topic_news.last 2
      @last_news = NewsDecorator.decorate_collection News.feed @news.id
      @members = Member.where id: @news.tags.active.members.map(&:target_id)
      @strings = @news.tags.active.string
      @not_strings = @news.tags.active.events + @news.tags.active.activity_lines + @news.tags.active.teams
      @previous_news = News.previous @news.id, on: :published
      @next_news = News.next @news.id, on: :published
      @same_events = ::EventDecorator.decorate_collection same_events
      @popular_news = NewsDecorator.decorate_collection News.popular.first 6
      @banner = Banner.active.with_vertical.actual.last
    else
      redirect_to not_found_page_path and return
    end
  end

  private

  def same_events
    activity_line = @news.tags.activity_lines.map(&:target).first
    source = activity_line ? activity_line.events : ::Event
    source.confirmed.near_future.first 3
  end
end
