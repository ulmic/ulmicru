class Api::Admin::TagsController < Api::Admin::ApplicationController
  def create
    @tag_form = TagForm.new_with_model
    @tag_form.submit params[:tag]
    if @tag_form.save
      render json: @tag_form.model
    else
      head :bad_request
    end
  end
end
