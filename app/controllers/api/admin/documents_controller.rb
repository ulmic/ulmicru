class Api::Admin::DocumentsController < Api::Admin::ApplicationController
  def create
    @document_form = DocumentForm.new_with_model
    @document_form.submit params[:document]
    if @document_form.save
      render json: @document_form.model
    else
      render action: :new
    end
  end
end
