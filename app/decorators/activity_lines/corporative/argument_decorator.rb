class ActivityLines::Corporative::ArgumentDecorator < ApplicationDecorator
  delegate_all

  decorates_association :member
end
