class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  before_filter :redirect_to_unviewed

  def index
    @report = if signed_as_admin? 
      {
        users_count: User.count,
        event_registrations_count: Event::Registration.count,
        uniq_users_event_registrations_count: Event::Registration.all.map(&:user).uniq.count,
        uniq_logged_users_for_month_count: LoggedAction.where(action_type: :sign_in).
          where('created_at > ?', DateTime.now - 1.month).map(&:user).uniq.count,
        new_users_count: User.where('created_at > ?', DateTime.now - 1.month).count,
        news_views: View.where(record_type: 'News').count,
        article_views: View.where(record_type: 'Article').count,
        email_sended: Delivery::Campaign.done.map(&:contacts).flatten.count,
        email_sended_this_month: Delivery::Campaign.done.where('created_at > ?', DateTime.now - 1.month).map(&:contacts).flatten.count
      }
              end
  end

  private

  def redirect_to_unviewed
    unless current_user.admin?
      redirect_to admin_events_path
    end
  end
end
