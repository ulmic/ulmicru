class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @unviewed = {}
    Concerns::NotificatableItems.items.each do |item|
      @unviewed[item.to_s.pluralize(:en).to_sym] = Kaminari.paginate_array(item.to_s.camelize.constantize.unviewed.decorate).page params[:page]
    end
    @tag = Tag.new
  end
end
