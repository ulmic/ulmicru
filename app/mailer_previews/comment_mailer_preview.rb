class CommentMailerPreview
  def create
    CommentMailer.create comment, user
  end
end
