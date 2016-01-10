class Web::Admin::TrashController < Web::Admin::ApplicationController
  include Concerns::Trash

  def index
    @type = resource_type
    @items = resource_type.removed.page(params[:page]).decorate
  end

  def restore
    item = resource_type.find params[:id]
    item.restore
    redirect_to type_admin_trash_index_path to_trash_param resource_type
  end

  def destroy
    item = resource_type.find params[:id]
    item.destroy
    redirect_to type_admin_trash_index_path to_trash_param resource_type
  end

  private

  def resource_type
    parse_trash_param params[:type]
  end
end
