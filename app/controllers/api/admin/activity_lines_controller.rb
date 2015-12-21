class Api::Admin::ActivityLinesController < Api::Admin::ApplicationController
  def index
    if params[:q].present?
      @activity_lines = ActivityLine.search_everywhere params[:q][:term]
    else
      @activity_lines = ActivityLine.all
    end
    render json: @activity_lines.to_json(only: [:id, :title])
  end
end
