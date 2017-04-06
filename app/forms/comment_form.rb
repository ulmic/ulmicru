class CommentForm < ApplicationReform
  properties :text, :user_id, :parent_id, :record_id, :record_type, :comment_type
end
