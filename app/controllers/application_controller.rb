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
      if request.host.include?('ul-lider.ru') && request.path == root_path
        redirect_to activity_lines_lider_ya_lider_path(15), status: :moved_permanently
        return
      end
      Project.find_each do |project|
        if request.host.include?(project.url) && request.path != project_path(project)
          redirect_to project_path project
          return
        end
      end
    end
  end

  def get_categories
    @categories_tree = Category.get_tree
  end
end
