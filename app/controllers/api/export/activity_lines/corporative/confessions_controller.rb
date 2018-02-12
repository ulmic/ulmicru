class Api::Export::ActivityLines::Corporative::ConfessionsController < Api::Export::ApplicationController
  def index
    activity_lines = ::ActivityLines::Corporative::Confession.all
    render json: activity_lines,
           each_serializer: ::ActivityLines::Corporative::ConfessionPresenter,
           status: :ok
  end
end
