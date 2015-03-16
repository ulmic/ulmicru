class ArticleForm < ApplicationForm
  self.main_model = :article

  attributes :title, :body, required: true
  attributes :view, :category_id
end
