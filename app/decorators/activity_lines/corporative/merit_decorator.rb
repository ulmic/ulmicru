class ActivityLines::Corporative::MeritDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def self.collections
    [ :active, :removed ]
  end
end
