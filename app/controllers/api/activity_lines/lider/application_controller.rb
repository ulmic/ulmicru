class Api::ActivityLines::Lider::ApplicationController < Api::ApplicationController
  protected

  def check_ya_lider_token
    head :bad_request unless params[:token] == ActivityLines::Lider::YaLider.current.first.tokens.first.content
    return
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == Rails.application.secrets.api_token
    end
  end

  def ul_lider_access_control_origin
    headers['Access-Control-Allow-Origin'] = configus.it_projects.ul_lider.url
  end
end
