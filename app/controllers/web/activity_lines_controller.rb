class Web::ActivityLineController < Web::ApplicationController
  def show
    @activity_line = ActivityLine.find(params[:id])
  end
end
