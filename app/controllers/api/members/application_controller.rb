class Api::Members::ApplicationController < Api::ApplicationController
  before_filter :authenticate_member!
end
