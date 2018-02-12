class Api::Export::ActivityLines::Corporative::OnlineConferencesController < Api::Export::ApplicationController
  def index
    activity_lines = ::ActivityLines::Corporative::OnlineConference.all
    render json: activity_lines,
           each_serializer: ::ActivityLines::Corporative::OnlineConferencePresenter,
           status: :ok
  end
end
