class Web::NewsController < ApplicationController
  def index
    
  end

  def show
    @news = News.find(params[:id]).decorate
    if !@news.is_published?
      redirect_to not_found_errors_path
    end
  end
end
