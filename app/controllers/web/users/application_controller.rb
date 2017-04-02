class Web::Users::ApplicationController < Web::ApplicationController
  before_filter :authenticate_user!
  layout 'web/users/application'
end
