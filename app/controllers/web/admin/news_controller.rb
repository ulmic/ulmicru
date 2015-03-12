class Web::Admin::NewsController < Web::Admin::ApplicationController
  def index
    @published_news = NewsDecorator.decorate_collection News.published.order('published_at DESC') 
    @unpublished_news = NewsDecorator.decorate_collection News.unpublished.order('published_at DESC')
  end

  def show
    @news = NewsDecorator.decorate News.find params[:id]
    if !@news.is_published?
      #FIXME there 404 error path
    end
  end

  def create
    @news = News.new
    @news_form = NewsForm.new @news
    params[:news][:user_id] = current_user.id
    @news_form.submit params[:news]
    if @news_form.save
      redirect_to admin_news_index_path
    else
      flash[:errors] = @news_form.errors
      flash[:model_name_class] = "News" 
      redirect_to action: :new, :news => params[:news] 
    end
  end
  def new
    @news = News.new
    @news_form = NewsForm.new @news
    if params[:news].present?
      @news_form.submit params[:news]
    end
      @news_form = NewsForm.new @news
  end

  def edit
    @news = News.find params[:id]
    @news_form = NewsForm.new @news
  end

  def update
    @news = News.find params[:id]
    @news_form = NewsForm.new(@news)
    @news_form.submit params[:news]
    if @news_form.save
      redirect_to admin_news_index_path
    else 
      redirect_to action: :edit
    end
  end

  def destroy
    @news = News.find params[:id]
    @news.remove
    redirect_to admin_news_index_path
  end
end
