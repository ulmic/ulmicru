class ArticleForm < ActiveForm::Base
  attributes :title, :body, :user_id, :view
end
