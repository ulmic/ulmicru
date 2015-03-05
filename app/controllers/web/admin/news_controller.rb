class Web::Admin::NewsController < Web::Admin::ApplicationController
  def index
    @published_news = Web::NewsDecorator.decorate_collection News.published.order('created_at DESC') #FIXME using another decorator in that file
    @unpublished_news = Web::NewsDecorator.decorate_collection News.unpublished.order('created_at DESC')
  end

  def show
    @news = Web::NewsDecorator.decorate News.find params[:id]#FIXME I'm don't know how to include decorate there into code
    if !@news.is_published?
      #FIXME there 404 error path
    end
  end

  def create
    @news = News.new
    @news_form = NewsForm.new @news
    @news_form.submit params[:user]
    if @news_form.save
      redirect_to admin_news_path
    else 
      redirect_to action: :new
    end
  end
  def new
    @news = News.new
    @news_form = NewsForm.new @news
  end

  def edit
    @news = News.find params[:id]
    @news_form = NewsForm.new @news
  end

  def update
    @news = News.find params[:id]
    @news_form = NewsForm.new(@news)
    @news_form.submit params[:user]
    if @news_form.save
      redirect_to admin_news_path
    else 
      redirect_to action: :edit
    end
  end

  def destroy
    @news = News.find params[:id]
    @news.remove
    redirect_to admin_news_path
  end
end
