require 'test_helper'

class Web::ArticlesControllerTest < ActionController::TestCase
  setup do
    @category = create :category
    @article = Article.last
  end

  test "should get show" do
    get :show, id: @article
    assert_response :success, @response.body
  end
end
