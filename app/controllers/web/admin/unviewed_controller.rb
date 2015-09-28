class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @unviewed = {}
    Concerns::NotificatableItems.items.each do |item|
      @unviewed[item.to_s.pluralize(:en).to_sym] = item.to_s.camelize.constantize.unviewed.page(params[:page]).decorate
    end
    @tag = Tag.new
  end
end
