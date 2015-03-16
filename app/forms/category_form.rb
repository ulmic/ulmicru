class CategoryForm < ApplicationForm
  self.main_model = :category

  attributes :name, required: true
  attributes :is_last, :parent_id
end
