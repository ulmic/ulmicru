class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories

  if Rails.env.staging?
    before_filter :required_basic_auth!
  end

  private 
  def get_categories
    @categories_tree = Category.get_tree
  end
end
