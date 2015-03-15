class CategoryForm < ActiveForm::Base
  self.main_model = :category

  attributes :name, required: true
  attributes :is_last, :parent_id
end
