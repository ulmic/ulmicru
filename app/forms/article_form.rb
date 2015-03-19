class ArticleForm < ApplicationForm
  self.main_model = :article

  attributes :title, :body, :user_id, required: true
  attributes :view, :category_id
end
