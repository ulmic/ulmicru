class Web::Members::ApplicationController < Web::ApplicationController
  before_filter :authenticate_member!
end
