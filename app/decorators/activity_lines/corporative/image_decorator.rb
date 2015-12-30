class ActivityLines::Corporative::ImageDecorator < ApplicationDecorator
  delegate_all

  def short_name
    object.member.decorate.short_name
  end
end
