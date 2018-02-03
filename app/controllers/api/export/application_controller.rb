class Api::Export::ApplicationController < Api::ApplicationController
  before_action :check_auth_connection

  def check_auth_connection
    raise unless params[:pass] == ENV['EXPORT_PASS']
  end
end
