class Web::Admin::FeedbackController < Web::Admin::ApplicationController
  def index
    @feedback = {}
    @feedback[:unviewed] = Feedback.unviewed.page params[:page]
    @feedback[:fixing] = Feedback.fixing.page params[:page]
    @feedback[:done] = Feedback.done.page params[:page]
    @feedback[:declined] = Feedback.declined.page params[:page]
  end

  def new
    @feedback_form = FeedbackForm.new_with_model
  end

  def edit
    @feedback_form = FeedbackForm.find_with_model params[:id]
  end

  def create
    @feedback_form = FeedbackForm.new_with_model
    @feedback_form.submit(params[:feedback])
    if @feedback_form.save
      redirect_to admin_feedback_index_path
    else
      render action: :new
    end
  end

  def update
    @feedback_form = FeedbackForm.find_with_model params[:id]
    @feedback_form.submit(params[:feedback])
    if @feedback_form.save
      redirect_to edit_admin_feedback_path @feedback_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @feedback = Feedback.find params[:id]
    @feedback.destroy
    redirect_to admin_feedback_index_path
  end
end
