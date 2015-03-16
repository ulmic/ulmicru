class Web::Admin::ArticlesController < Web::Admin::ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article_form = ArticleForm.new_with_model
    @article_form.category_id = params[:selected_category]
  end

  def create
    @article_form = ArticleForm.new_with_model

    params[:article][:user_id] = current_user.id if current_user.present?
    @article_form.submit params[:article]
    if @article_form.save
      redirect_to admin_articles_path
    else
      render action: :new
    end
  end

  def edit
    @article_form = ArticleForm.find_with_model params[:id]
  end

  def update
    @article_form = ArticleForm.find_with_model params[:id]
    @article_form.submit params[:article]
    if @article_form.save
      redirect_to admin_articles_path
    else
      render action: :edit
    end
  end

  def destroy
    @article = Article.find params[:id]
    @article.remove
    redirect_to admin_articles_path
  end
end
