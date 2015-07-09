class NewsForm < ApplicationForm
  self.main_model = :news

  attributes :title, :body, :published_at, :photo, :lead, required: false
  attributes :user_id
end
