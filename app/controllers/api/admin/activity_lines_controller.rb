class Api::Admin::ActivityLinesController < Api::Admin::ApplicationController
  def index
    @activity_lines = ActivityLine.all
    render json: { model: 'ActivityLine', list: @activity_lines.to_json(only: [:id, :title]) }
  end
end
