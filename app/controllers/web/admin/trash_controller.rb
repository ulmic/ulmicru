class Web::Admin::TrashController < Web::Admin::ApplicationController
  def index
    @type = params[:type].capitalize
    @items = "#{@type}Decorator".constantize.decorate_collection @type.constantize.removed
  end

  def restore
    type = params[:type]
    item = type.capitalize.constantize.find params[:id]
    item.restore
    redirect_to "/admin/trash/index/#{type}"
  end

  def destroy
    type = params[:type]
    item = type.capitalize.constantize.find params[:id]
    item.destroy
    redirect_to "/admin/trash/index/#{type}"
  end
end
