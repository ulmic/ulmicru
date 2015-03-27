class Web::ApplicationController < ApplicationController
  include Concerns::AuthManagment

  before_filter :load_categories_tree

  def load_categories_tree
    @first_category = Category.find_by_name 'Кто мы такие'
  end
end
