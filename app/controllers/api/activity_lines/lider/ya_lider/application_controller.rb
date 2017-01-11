class Api::ActivityLines::Lider::YaLider::ApplicationController < Api::ApplicationController
  before_filter :check_ya_lider_token

  protected

  def check_ya_lider_token
    head :bad_request unless params[:token] == ActivityLines::Lider::YaLider.current.first.tokens.first.content
    return
  end
end
