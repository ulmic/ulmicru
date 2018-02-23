class ActivityLines::Corporative::ConfessionPresenter < ApplicationPresenter
  attributes :year, :member_id, :nomination, :created_at, :updated_at

  has_one :member, serializer: UserPresenter
end
