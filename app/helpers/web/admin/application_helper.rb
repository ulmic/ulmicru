module Web::Admin::ApplicationHelper
  def notification_count
    Member.not_confirmed.count
  end
end
