class Api::Admin::ApplicationController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_format
  before_filter :authenticate_admin!

  def set_format
    request.format = :json
  end
end
