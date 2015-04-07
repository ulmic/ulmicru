class TagForm < ApplicationForm
  self.main_model = :tag

  attributes :text, :tag_type, :record_id, :record_type, :target_type, :target_id
end
