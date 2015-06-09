module Web::Admin::ApplicationHelper
  include Localities
  include Places

  def notification_count
    Member.unviewed.count + Questionary.unviewed.count + News.unviewed.count + Event.unviewed.count
  end

  def state_color(item)
    if item.methods.include? :unviewed?
      :success if item.unviewed?
    end
  end
end
