class Web::Admin::TrashController < Web::Admin::ApplicationController
  def index
    if params[:type].to_sym.in? trash_models
      @type = resource_type
      @items = resource_type.removed.page(params[:page]).decorate
    else
      redirect_to not_found_page_path
    end
  end

  def restore
    item = resource_type.find params[:id]
    item.restore
    redirect_to type_admin_trash_index_path(resource_type)
  end

  def destroy
    item = resource_type.find params[:id]
    item.destroy
    redirect_to type_admin_trash_index_path(resource_type)
  end

  private

  def resource_type
    params[:type].camelize.constantize
  end
end
