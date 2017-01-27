class ActivityLines::Corporative::MeritDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def self.collections
    [ :honorary_members, :second_degree ]
  end
end
