class Web::ApplicationController < ApplicationController
  before_filter :load_categories_tree

  def load_categories_tree
    @first_category = Category.find_by_name 'Кто мы такие'
    if signed_in?
      @korporative_category = Category.find_by_name 'Корпоративные проекты'
    end
  end
end
