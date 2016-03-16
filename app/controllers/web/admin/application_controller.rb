class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_admin!
  before_filter :check_declared_scopes, only: :index

  layout 'web/admin/application'

  include ModelsConcern

  protected

  def choose_users
    @users = User.presented.decorate
  end

  def check_declared_scopes
    unless controller_name.classify.constantize.scopes.map(&:to_s).include? params[:scope]
      redirect_to params.except(:scope)
    end
  end
end
