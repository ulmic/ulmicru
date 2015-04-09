class Web::NewsController < Web::ApplicationController
  def index
    @news = News.published.decorate
  end

  def show
    @news = News.find(params[:id]).decorate
    activity_line_tag = @news.tags.activity_lines.first
    @activity_line = ActivityLineDecorator.decorate activity_line_tag.target if activity_line_tag
    event_tag = @news.tags.events.first
    @event = EventDecorator.decorate event_tag.target if event_tag
    topic_news_tags = @news.tags.last 2
    @topic_news = []
    topic_news_tags.each do |tag|
      news_tag = Tag.where(target_type: tag.target_type, record_type: 'News').where("record_id != #{@news.id}").last
      @topic_news << NewsDecorator.decorate(news_tag.record) if news_tag
    end
    unless @news.is_published?
      #FIXME there 404 error path
    end
  end
end
