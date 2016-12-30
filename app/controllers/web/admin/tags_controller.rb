class Web::Admin::TagsController < Web::Admin::ApplicationController
  def index
    if params[:search]
      tags = Tag.active.search_everywhere params[:search]
    else
      tags = Tag.send params[:scope]
    end
    @tags = tags.page(params[:page]).decorate
  end

  def new
    @tag_form = TagForm.new_with_model
  end

  def edit
    if Tag.where(id: params[:id]).any?
      @tag_form = TagForm.find_with_model params[:id]
    else
      redirect_to admin_tags_path
    end
  end

  def create
    @tag_form = TagForm.new_with_model
    @tag_form.submit(params[:tag])
    if @tag_form.save
      redirect_to admin_tags_path
    else
      render action: :new
    end
  end

  def update
    @tag_form = TagForm.find_with_model params[:id]
    @tag_form.submit(params[:tag])
    if @tag_form.save
      redirect_to admin_tags_path
    else
      render action: :edit
    end
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.remove
    redirect_to admin_tags_path
  end
end
