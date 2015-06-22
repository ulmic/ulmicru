class Web::ApplicationController < ApplicationController
  before_filter :load_categories_tree

  include Concerns::NotificationManagment

  def load_categories_tree
    @first_category = Category.find_by_name 'Кто мы такие'
    contact_category = Category.find_by_name 'Контакты'
    @contact_article = contact_category.articles.first if contact_category
    if signed_in?
      @korporative_category = Category.find_by_name 'Корпоративные проекты'
    end
    @feedback = FeedbackForm.new_with_model
  end
end
