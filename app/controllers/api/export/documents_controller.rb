class Api::Export::DocumentsController < Api::Export::ApplicationController
  def index
    documents = Document.all
    render json: documents,
           each_serializer: DocumentPresenter,
           status: :ok
  end
end
