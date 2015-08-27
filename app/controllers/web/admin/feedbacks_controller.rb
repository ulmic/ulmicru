class Web::Admin::FeedbacksController < Web::Admin::ApplicationController
  def index
    @feedback = {}
    @feedback[:unviewed] = Kaminari.paginate_array(Feedback.unviewed.decorate).page params[:page]
    @feedback[:fixing] = Kaminari.paginate_array(Feedback.fixing.decorate).page params[:page]
    @feedback[:done] = Kaminari.paginate_array(Feedback.done.decorate).page params[:page]
    @feedback[:declined] = Kaminari.paginate_array(Feedback.declined.decorate).page params[:page]
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
      redirect_to admin_feedbacks_path
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
    redirect_to admin_feedbacks_path
  end
end
