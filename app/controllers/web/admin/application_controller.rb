class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_admin!
  layout 'web/admin/application'

  protected

  def choose_members
    @members = Member.presented.decorate
  end
end
