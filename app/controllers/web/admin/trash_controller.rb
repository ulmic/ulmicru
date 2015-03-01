class Web::Admin::TrashController < Web::Admin::ApplicationController
  def index
    @type = params[:type].capitalize
    @items = Object.const_get("#{@type}Decorator").decorate_collection Object.const_get(@type).removed
  end

  def restore
    type = params[:type]
    item = Object.const_get(type.capitalize).find params[:id]
    item.restore
    redirect_to "/admin/trash/index/#{type}"
  end

  def destroy
    type = params[:type]
    item = Object.const_get(type.capitalize).find params[:id]
    item.destroy
    redirect_to "/admin/trash/index/#{type}"
  end
end
