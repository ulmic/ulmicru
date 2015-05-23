class Api::Users::ApplicationController < Api::ApplicationController
  before_filter :authenticate_user!
end
