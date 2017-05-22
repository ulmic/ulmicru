class Web::ActivityLinesController < Web::ApplicationController
  def show
    @activity_line = ActivityLine.find(params[:id]).decorate
  end
end
