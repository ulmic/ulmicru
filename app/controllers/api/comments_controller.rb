class Api::CommentsController < Api::ApplicationController
  def index
    comments = CommentCollectionDecorator.new(Comment.where(record_type: params[:record_type], record_id: params[:record_id]).includes(:user).published).with_users
    render json: comments
  end

  def create
    @comment = CommentForm.new_with_model
    params[:comment][:user_id] = current_user.id
    if @comment.submit params[:comment]
      render json: {
                     id: @comment.id,
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
      @comment.remove
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
