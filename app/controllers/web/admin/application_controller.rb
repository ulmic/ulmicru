class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_admin!
  layout 'web/admin/application'

  include Concerns::ModelsConcern

  protected

  def choose_users
    @users = User.presented.decorate
  end
end
