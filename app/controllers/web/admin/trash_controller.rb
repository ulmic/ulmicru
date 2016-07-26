class Web::Admin::TrashController < Web::Admin::ApplicationController
  include Concerns::Trash
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  skip_before_action :save_object
  skip_after_action :log_action
  after_action :log_destroyed_object, only: :destroy

  def index
    @type = resource_type
    items = resource_type.removed
    items = items.search_everywhere(params[:search]) if params[:search]
    @items = items.page(params[:page]).decorate
  end

  def restore
    item = resource_type.find params[:id]
    item.restore
    redirect_to type_admin_trash_index_path to_trash_param resource_type
  end

  def destroy
    @item = resource_type.find params[:id]
    @item.destroy
    redirect_to type_admin_trash_index_path to_trash_param resource_type
  end

  private

  def resource_type
    parse_trash_param params[:type]
  end

  def log_destroyed_object
    if self.status == 302
      LoggedAction.create! user_id: current_user.id,
	record_type: resource_type.model_name.name,
	record_id: params[:id],
	action_type: :delete,
	params: @item.attributes
    end
  end
end
