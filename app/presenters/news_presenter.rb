class NewsPresenter < ApplicationPresenter
  attributes :title, :body, :published_at, :photo, :user_id, :created_at, :updated_at, :state, :lead

  def published_at
    object.published_at.iso8601
  end

  def photo
    object.photo.url
  end
end
