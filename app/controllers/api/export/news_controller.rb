class Api::Export::NewsController < Api::Export::ApplicationController
  def index
    news = News.all
    render json: news,
           each_serializer: NewsPresenter,
           status: :ok
  end
end
