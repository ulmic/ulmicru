class Web::ApplicationController < ApplicationController
  include Concerns::AuthManagment

  before_filter :load_categories_tree

  def load_categories_tree
  end
end
