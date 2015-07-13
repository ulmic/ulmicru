class Api::CommentsController < Api::ApplicationController
  def create
    @comment = CommentForm.new_with_model
    params[:comment][:user_id] = current_user.id
    @comment.submit params[:comment]
    if @comment.save
      render json: { id: @comment.id,
                     name: @comment.user.decorate.short_name,
                     text: @comment.text,
                     image: (@comment.user.type == 'Member' ? @comment.user.decorate.element_avatar.url : @comment.user.default_avatar)
                   }
    else
      head :bad_request
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if @comment.user_id == current_user.id || current_user.role.admin?
      @comment.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
