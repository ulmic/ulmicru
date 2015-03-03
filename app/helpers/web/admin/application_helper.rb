module Web::Admin::ApplicationHelper
  def notification_count
    Member.not_confirmed.count
  end
  def state_color(item)
    :success if item.not_confirmed?
  end
end
