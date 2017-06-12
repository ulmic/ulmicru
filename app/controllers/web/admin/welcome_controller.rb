class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  before_filter :redirect_to_unviewed

  def index
    @report = if signed_as_admin? 
      most_viewed_news_count = News.joins(:page_views).select('news.*, count(views.id) as vcount').group('news.id').order('vcount DESC').first
      most_viewed_event_count = ::Event.joins(:page_views).select('events.*, count(views.id) as vcount').group('events.id').order('vcount DESC').first
      counts = {}
      member_id = View.where(record_type: 'Member').map(&:record_id).group_by(&:itself).each do |k, v|
        counts[k] = v.length
      end.max_by do |element|
        element.last.count
      end
      member = Member.find member_id[0]
      {
        users_count: User.count,
        event_registrations_count: Event::Registration.count,
        uniq_users_event_registrations_count: Event::Registration.all.map(&:user).uniq.count,
        uniq_logged_users_for_month_count: LoggedAction.where(action_type: :sign_in).
          where('created_at > ?', DateTime.now - 1.month).map(&:user).uniq.count,
        new_users_count: User.where('created_at > ?', DateTime.now - 1.month).count,
        email_sended: ::Delivery::Campaign.done.map(&:contacts).flatten.count,
        email_sended_this_month: Delivery::Campaign.done.where('created_at > ?', DateTime.now - 1.month).map(&:contacts).flatten.count,
        event_views: View.where(record_type: 'Event').count,
        member_views: View.where(record_type: 'Member').count,
        most_viewed_news: "#{most_viewed_news_count.title} (#{most_viewed_news_count.page_views.count})",
        most_viewed_event: "#{most_viewed_event_count.title} (#{most_viewed_event_count.page_views.count})",
        member: "#{member.decorate.short_name} (#{member_id[1].count})",
        contact_emails_count: Delivery::ContactEmail.presented.count,
        clicks_count: Click.count
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
