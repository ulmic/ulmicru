class CommentForm < ApplicationForm
  self.main_model = :comment

  attributes :text, :user_id, :parent_id, :record_id, :record_type
end
