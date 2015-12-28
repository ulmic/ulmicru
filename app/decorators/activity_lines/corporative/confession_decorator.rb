class ActivityLines::Corporative::ConfessionDecorator < ApplicationDecorator
  delegate_all

  def short_name
    object.member.decorate.short_name
  end

  alias name short_name
end
