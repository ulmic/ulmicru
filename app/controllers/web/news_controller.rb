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
    @members = @news.tags.members.map &:target
    @strings = @news.tags.string
    @news.increase_views
  end
end
