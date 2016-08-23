class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  skip_before_filter :check_declared_scopes
  skip_before_filter :collections_counts
  before_filter :unviewed_counts
  before_filter :check_notificatable_items

  def index
    if params[:items].present?
      @unviewed = params[:items].to_s.classify.constantize.need_to_review.page(params[:page]).decorate
      @tag = Tag.new
    end
  end

  private

  def check_notificatable_items
    any_items_key = @counts.keys.select { |k| @counts[k] != 0 }.first
    if any_items_key
      if params[:items].present?
        unless Concerns::NotificatableItems.items.include? params[:items].to_sym
          redirect_to params.except(:items)
        end
      else
        redirect_to admin_unviewed_index_path items: any_items_key
      end
    end
  end

  def unviewed_counts
    @counts = {}
    Concerns::NotificatableItems.items.each do |item|
      @counts[item] = item.to_s.classify.constantize.unviewed.count 
    end
  end
end
