class Api::ActivityLines::Lider::YaLider::ApplicationController < Api::ApplicationController
  before_filter :check_ya_lider_token
  before_filter :authenticate

  private

  def check_ya_lider_token
    head :bad_request unless params[:token] == ActivityLines::Lider::YaLider.current.first.tokens.first.content
    return
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == Rails.application.secrets.api_token
    end
  end
end
