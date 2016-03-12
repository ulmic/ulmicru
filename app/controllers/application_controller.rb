class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories

  include Concerns::AuthManagment
  include Concerns::TechinalPagesManagment
  include Concerns::ActionLogger
  include DatesHelper

  if Rails.env.staging?
    before_filter :required_basic_auth!
  end

  if Rails.env.production?
    anchor = "view_#{rand(4) + 1}"

    rescue_from ActionView::MissingTemplate, ActiveRecord::RecordNotFound, NoMethodError do |exception|
      Rails.logger.warn "ERROR MESSAGE: #{exception.message}"
      Rails.logger.warn "BACKTRACE: #{exception.backtrace.first(30).join("\n")}"
      redirect_to server_error_page_path
    end
  end

  private

  def get_categories
    @categories_tree = Category.get_tree
  end
end
