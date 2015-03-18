module Web::Admin::ApplicationHelper
  include Localities
  def notification_count
    Member.unviewed.count + Questionary.unviewed.count
  end
  def state_color(item)
    :success if item.unviewed?
  end
end
