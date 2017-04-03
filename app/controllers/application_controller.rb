class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_categories
  before_filter :redirect_to_another_main_page

  include Concerns::AuthManagment
  include Concerns::TechinalPagesManagment
  include Concerns::ActionLogger
  include Concerns::ContactsSubscriptionsManagment
  include Concerns::ItProjectsConcern
  include DatesHelper

  private

  def redirect_to_another_main_page
    unless Rails.env.test?
      if request.host.include?('it-way.pro') && request.path != main_page_of('it-way.pro')
        redirect_to main_page_of 'it-way.pro'
      elsif request.host.include?('ul-lider.ru') && request.path == ''
        redirect_to activity_lines_lider_ya_lider_path(15), status: :moved_permanently
      end
    end
  end

  def get_categories
    @categories_tree = Category.get_tree
  end
end
