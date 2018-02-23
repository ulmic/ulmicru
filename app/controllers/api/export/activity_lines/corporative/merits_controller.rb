class Api::Export::ActivityLines::Corporative::MeritsController < Api::Export::ApplicationController
  def index
    activity_lines = ::ActivityLines::Corporative::Merit.all
    render json: activity_lines,
           each_serializer: ::ActivityLines::Corporative::MeritPresenter,
           includes: [ :member ],
           status: :ok
  end
end
