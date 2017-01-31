class Api::ActivityLines::Lider::YaLidersController < Api::ActivityLines::Lider::ApplicationController
  before_filter :ul_lider_access_control_origin

  def show
    contest = ActivityLines::Lider::YaLider.find params[:id]
    if contest.present?
      render json: contest.attributes.to_json
    else
      head :bad_request
    end
  end
end
