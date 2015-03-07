class Web::Users::ApplicationController < Web::ApplicationController
  before_filter :authenticate_user!
end
