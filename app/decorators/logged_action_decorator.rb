class LoggedActionDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.user.decorate.short_name} #{object.record.decorate.name}" if object
  end

  def user_short_name
    object.user.decorate.short_name
  end
end
