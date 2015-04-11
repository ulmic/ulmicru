class Web::Admin::DocumentsController < Web::Admin::ApplicationController
  def index
    @documents = Document.presented
  end

  def new
    @document_form = DocumentForm.new_with_model
  end

  def edit
    @document_form = DocumentForm.find_with_model params[:id]
  end

  def create
    @document_form = DocumentForm.new_with_model
    @document_form.submit(params[:document])
    if @document_form.save
      redirect_to admin_documents_path
    else
      render action: :new
    end
  end

  def update
    @document_form = DocumentForm.find_with_model params[:id]
    @document_form.submit(params[:document])
    if @document_form.save
      redirect_to admin_documents_path
    else
      render action: :edit
    end
  end

  def destroy
    @document = Document.find params[:id]
    @document.remove
    redirect_to admin_documents_path
  end
end
