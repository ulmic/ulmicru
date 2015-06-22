class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_admin!
  before_filter :notification_count
  layout 'web/admin/application'

  protected

  def choose_members
    @members = Member.presented.decorate
  end

  def choose_teams
    @teams = Team.active.decorate
  end

  def notification_count
    collections = [ :member, :questionary, :news, :event, :user, :feedback ]
    @notification_count = 0
    collections.each do |collection_type|
      @notification_count += collection_type.to_s.capitalize.constantize.unviewed.count
    end
  end
end
