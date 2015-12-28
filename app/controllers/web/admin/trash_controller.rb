class Web::Admin::TrashController < Web::Admin::ApplicationController
  def index
    @type = resource_type
    @items = resource_type.removed.page(params[:page]).decorate
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
    resource = nil
    if params[:type].to_sym.in? trash_models
      resource = params[:type]
    else
      modules = params[:type].split('-')
      if modules.count > 1 && modules.all? { |mod| mod.to_sym.in?(trash_modules) || mod.to_sym.in?(trash_models) }
        resource = modules.join '/'
      end
    end
    resource.camelize.constantize
  end
end
