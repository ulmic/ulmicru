class Api::CommentsController < Api::ApplicationController
  def create
    @comment = CommentForm.new_with_model
    @comment.submit params[:comment]
    if @comment.save
      head :ok
    else
      head :bad_request
    end
  end
end
