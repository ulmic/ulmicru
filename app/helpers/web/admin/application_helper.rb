module Web::Admin::ApplicationHelper
  def notification_count
    Member.unviewed.count
  end
  def state_color(item)
    :success if item.unviewed?
  end
end
