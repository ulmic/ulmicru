class AddCommentsTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_type, :text, default: :user
  end
end
