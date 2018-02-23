class Api::Export::TagsController < Api::Export::ApplicationController
  def index
    tags = Tag.all
    render json: tags,
           each_serializer: TagPresenter,
           status: :ok
  end
end
