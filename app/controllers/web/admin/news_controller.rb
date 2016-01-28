class Web::Admin::NewsController < Web::Admin::ApplicationController
  def index
    @news = {}
    @news[:published] = News.published.page(params[:page]).decorate
    @news[:unpublished] = News.unpublished.page(params[:page]).decorate
    @news[:unviewed] = News.unviewed.order('published_at DESC').page(params[:page]).decorate
    @news[:main] = News.main.page(params[:page]).decorate
    @news[:search] = News.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
  end

  def create
    @news_form = NewsForm.new_with_model

    # FIXME because sessions work wrong
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
    # FIXME good realize of prev and next
    @news_form = NewsForm.find_with_model params[:id]
    @previous_news = News.where('id < ? AND state = ?', @news_form.model.id, @news_form.model.state).last
    @next_news = News.where('id > ? AND state = ?', @news_form.model.id, @news_form.model.state).first
  end

  def update
    @news_form = NewsForm.find_with_model params[:id]
    @news_form.submit params[:news]
    if @news_form.save
      redirect_to edit_admin_news_path @news_form.model
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
