class Web::ApplicationController < ApplicationController
  include Concerns::AuthManagment

  before_filter :load_categories_tree

  def load_categories_tree
    @first_category = Category.find_by_name 'Кто мы такие'
    if signed_in?
      @korporative_category = Category.find_by_name 'Корпоративные проекты'
    end
  end
end
