class Web::Admin::ArticlesController < Web::Admin::ApplicationController
  def index
    if params[:search]
      articles = Article.presented.search_everywhere params[:search]
    else 
      articles = Article.send params[:scopes]
    end
    @articles = articles.page(params[:page]).decorate
    @tag = Tag.new
  end

  def new
    @article_form = ArticleForm.new_with_model
    @categories = Category.presented.decorate
  end

  def create
    @article_form = ArticleForm.new_with_model

    params[:article][:user_id] = current_user.id if current_user.present?
    @article_form.submit params[:article]
    if @article_form.save
      redirect_to admin_articles_path
    else
      @categories = Category.presented.decorate
      render action: :new
    end
  end

  def edit
    @article_form = ArticleForm.find_with_model params[:id]
    @categories = Category.presented.decorate
  end

  def update
    @article_form = ArticleForm.find_with_model params[:id]
    @article_form.submit params[:article]
    if @article_form.save
      redirect_to edit_admin_article_path @article_form.model
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
