class ActivityLines::Corporative::ArgumentDecorator < ApplicationDecorator
  delegate_all

  def short_name
    object.member.decorate.short_name
  end
end
