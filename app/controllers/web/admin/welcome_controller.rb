class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  before_filter :redirect_to_unviewed

  def index
    @report = { 
      users_count: User.count,
      event_registrations_count: Event::Registration.count,
      uniq_users_event_registrations_count: Event::Registration.all.map(&:user).uniq.count,
      uniq_logged_users_for_month_count: LoggedAction.where(action_type: :sign_in).
	where('created_at > ?', DateTime.now - 1.month).map(&:user).uniq.count,
      new_users_count: User.where('created_at > ?', DateTime.now - 1.month).count,
      news_views: News.all.map(&:views).sum
    }
  end

  private

  def redirect_to_unviewed
    redirect_to admin_unviewed_index_path unless @notification_count == 0
  end
end
