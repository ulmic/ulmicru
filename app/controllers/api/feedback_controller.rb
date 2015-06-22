class Api::FeedbackController < Api::ApplicationController
  def create
    @feedback = FeedbackForm.new_with_model
    @feedback.submit params[:feedback]
    if @feedback.save
      head :ok
    else
      head :bad_request
    end
  end
end
