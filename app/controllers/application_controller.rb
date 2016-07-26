class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories

  include Concerns::AuthManagment
  include Concerns::TechinalPagesManagment
  include Concerns::ActionLogger
  include Concerns::ContactsSubscriptionsManagment
  include DatesHelper

  private

  def get_categories
    @categories_tree = Category.get_tree
  end
end
