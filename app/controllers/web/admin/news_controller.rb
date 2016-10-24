class Web::Admin::NewsController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def index
    if params[:search]
      news = News.search_everywhere params[:search]
    else
      news = News.send params[:scope]
    end
    @news = news.page(params[:page]).decorate
  end

  def create
    @news_form = NewsForm.new_with_model
    @news_form.submit params[:news]
    if @news_form.save
      Organization::Permissions.news[:need_to_review].each do |member|
        send_notification member, @news_form.model, :create
      end
      redirect_to admin_news_index_path
    else
      choose_members
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
    current_collection = @news_form.model.decorate.collection
    @news_form.submit params[:news]
    if @news_form.save
      redirect_to admin_news_index_path scope: current_collection,
        page: collection_page(@news_form.model, current_collection)
    else
      choose_members
      render action: :edit
    end
  end

  def destroy
    @news = News.find params[:id]
    @news.remove
    redirect_to admin_news_index_path
  end
end
