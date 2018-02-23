class ActivityLines::Corporative::MeritPresenter < ApplicationPresenter
  attributes :user_id, :nomination, :year, :state

  has_one :user, serializer: UserPresenter
end
