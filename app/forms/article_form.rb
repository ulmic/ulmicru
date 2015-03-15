class ArticleForm < ActiveForm::Base
  self.main_model = :article

  attributes :title, :body, required: true
  attributes :view
end
