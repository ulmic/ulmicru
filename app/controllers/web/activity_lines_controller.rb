class Web::ActivityLinesController < Web::ApplicationController
  def show
    @activity_line = ActivityLine.find(params[:id]).decorate
    @future_events = @activity_line.events.confirmed.future.decorate
    @last_news = NewsDecorator.decorate_collection News.order(published_at: :asc).published.where(id: @activity_line.tags.news.map(&:record_id)).last(8).reverse
  end
end
