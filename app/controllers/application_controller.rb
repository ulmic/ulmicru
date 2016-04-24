class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories
  before_filter :errors_view
  before_filter :basic_auth

  include Concerns::AuthManagment
  include Concerns::TechinalPagesManagment
  include Concerns::ActionLogger
  include DatesHelper

  private

  def get_categories
    @categories_tree = Category.get_tree
  end

  def basic_auth
    if Rails.env.staging?
      before_filter :required_basic_auth!
    end
  end

  def errors_view
    if Rails.env.production?
      rescue_from ActionView::MissingTemplate, ActiveRecord::RecordNotFound, NoMethodError do |exception|
	Rails.logger.warn "ERROR MESSAGE: #{exception.message}"
	Rails.logger.warn "BACKTRACE: #{exception.backtrace.first(30).join("\n")}"
	render '/web/pages/shared/_server_error', status: 500
      end
    end
  end

end
