class Web::Admin::CommentsController < Web::Admin::ApplicationController
  def index
    @comments = Comment.send(params[:scope]).page(params[:page]).decorate
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
      if @comment_form.model.comment_type.admin?
        @comment_form.model.record.logged_actions_associated_users.each do |user|
          send_notification user, @comment_form.model, :create
        end
      end
      redirect_to :back
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
