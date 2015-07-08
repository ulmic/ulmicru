class ArticleForm < ApplicationForm
  self.main_model = :article

  attributes :title, :user_id, required: true
  attributes :view, :body, :category_id
end
