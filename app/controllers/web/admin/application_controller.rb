class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_admin!
  layout 'web/admin/application'

  protected

  def choose_users
    @users = User.presented.decorate
  end

  def choose_members
    @members = Member.presented.decorate
  end

  def choose_teams
    @teams = Team.active.visible.decorate
  end
end
