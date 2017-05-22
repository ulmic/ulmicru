class Web::ActivityLinesController < Web::ApplicationController
  def show
    @activity_line = ActivityLine.find(params[:id]).decorate
    @future_events = @activity_line.events.confirmed.future.decorate
  end
end
