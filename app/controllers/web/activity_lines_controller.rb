class Web::ActivityLinesController < Web::ApplicationController
  before_filter :check_active_activity_line

  def show
    @future_events = @activity_line.events.confirmed.future.decorate
    @last_news = NewsDecorator.decorate_collection News.order(published_at: :asc).published.where(id: @activity_line.tags.news.map(&:record_id)).last(8).reverse
    @old_leaders = Position.old_positions.where(title: @activity_line.leader_title).map &:member
    View.create! user_id: current_user&.id, record_id: @activity_line.id, record_type: 'ActivityLine'
    @video = @activity_line.tags.videos.first&.record
  end

  private

  def check_active_activity_line
    @activity_line = ActivityLine.find(params[:id]).decorate
    if !(@activity_line.active? && @activity_line.organization_type.ulmic? && !@activity_line.activity_type.event_line?)
      redirect_to not_found_page_path and return
    end
  end
end
