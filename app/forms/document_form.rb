class DocumentForm < ApplicationForm
  self.main_model = :document

  attributes :title, :file
end
