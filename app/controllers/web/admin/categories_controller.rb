class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts

  def index
    @categories = Category.presented.decorate
  end

  def new
    @category_form = CategoryForm.new_with_model
    @category_form.parent_id = params[:id]
  end

  def create
    @category_form = CategoryForm.new_with_model
    @category_form.submit params[:category]
    if @category_form.save
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def edit
    @category_form = CategoryForm.find_with_model params[:id]
  end

  def update
    @category_form = CategoryForm.find_with_model params[:id]
    @category_form.submit params[:category]
    if @category_form.save
      redirect_to edit_admin_category_path @category_form.model
    else
      render action: :edit
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.remove
    redirect_to admin_categories_path
  end
end
