class ActivityLines::Corporative::MeritDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def name
    "Почётный знак за заслуги перед МИЦ #{object.nomination} #{object.user.decorate.short_name}"
  end
end
