class Web::Admin::CommentsController < Web::Admin::ApplicationController
  def index
    @comments = {}
    @comments[:unviewed] = Comment.unviewed.page(params[:page]).decorate
    @comments[:active] = Comment.active.page(params[:page]).decorate
  end

  def new
    @comment_form = CommentForm.new_with_model
  end

  def edit
    @comment_form = CommentForm.find_with_model params[:id]
  end

  def create
    @comment_form = CommentForm.new_with_model
    @comment_form.submit(params[:comment])
    if @comment_form.save
      redirect_to admin_comments_path
    else
      render action: :new
    end
  end

  def update
    @comment_form = CommentForm.find_with_model params[:id]
    @comment_form.submit params[:comment]
    if @comment_form.save
      redirect_to edit_admin_comment_path @comment_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to admin_comments_path
  end
end
