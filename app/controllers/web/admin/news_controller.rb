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
    @news_form = NewsForm.new_with_model

    #fix because sessions work wrong
    params[:news][:user_id] = current_user.id if current_user.present?

    @news_form.submit params[:news]
    if @news_form.save
      redirect_to admin_news_index_path
    else
      render action: :new
    end
  end

  def new
    @news_form = NewsForm.new_with_model
  end

  def edit
    @news_form = NewsForm.find_with_model params[:id]
  end

  def update
    @news_form = NewsForm.find_with_model params[:id]
    @news_form.submit params[:news]
    if @news_form.save
      redirect_to admin_news_index_path
    else
      render action: :edit
    end
  end

  def destroy
    @news = News.find params[:id]
    @news.remove
    redirect_to admin_news_index_path
  end
end
