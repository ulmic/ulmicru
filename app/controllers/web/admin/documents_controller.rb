class Web::Admin::DocumentsController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts

  def index
    @documents = Document.presented.page params[:page]
  end

  def new
    @document_form = DocumentForm.new_with_model
  end

  def edit
    @document_form = DocumentForm.find_with_model params[:id]
  end

  def create
    @document_form = DocumentForm.new_with_model
    import = params[:document][:import] == 'true'
    params[:document].delete :import
    @document_form.submit(params[:document])
    if @document_form.save
      if import
        collection = ::XlsParser.first_sheet_collection @document_form.model.file
        collection.each do |item|
          Delivery::ContactEmail.create! first_name: item[0], last_name: item[1], email: item[2]
        end
        redirect_to admin_delivery_contact_emails_path
      else
        redirect_to admin_documents_path
      end
    else
      render action: :new
    end
  end

  def update
    @document_form = DocumentForm.find_with_model params[:id]
    @document_form.submit(params[:document])
    if @document_form.save
      redirect_to edit_admin_document_path @document_form.model
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
