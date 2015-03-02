class Web::Admin::TrashController < Web::Admin::ApplicationController
  def index
    @type = resource_type
    @items = resource_type.removed.decorate
  end

  def restore
    item = resource_type.find params[:id]
    item.restore
    redirect_to  type_admin_trash_index_path(resource_type)
  end

  def destroy
    item = resource_type.find params[:id]
    item.destroy
    redirect_to  type_admin_trash_index_path(resource_type)
  end

  private

  def resource_type
    @_type ||= params[:type].capitalize.constantize
  end
end
