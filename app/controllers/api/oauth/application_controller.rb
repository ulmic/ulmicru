class Api::Oauth::ApplicationController < Api::ApplicationController
  before_action :doorkeeper_authorize!
end
