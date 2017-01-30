class Api::ActivityLines::Lider::YaLidersController < Api::ActivityLines::Lider::ApplicationController
  def show
    record = Token.where(content: params[:token]).first&.record
    if record&.is_a? ::ActivityLines::Lider::YaLider
      render json: record.attributes.to_json
    else
      head :bad_request
    end
  end
end
