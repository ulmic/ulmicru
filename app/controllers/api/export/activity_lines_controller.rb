class Api::Export::ActivityLinesController < Api::Export::ApplicationController
  def index
    activity_lines = ActivityLine.all
    render json: activity_lines,
           each_serializer: ActivityLinePresenter,
           status: :ok
  end
end
