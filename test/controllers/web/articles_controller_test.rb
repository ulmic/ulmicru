require 'test_helper'

class Web::ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = Article.last
  end

  test "should get show" do
    get :show, id: @article
    assert_response :success, @response.body
  end

  test 'should get show all articles' do
    if ENV['DB'] == 'prod'
      Article.find_each do |article|
        get :show, id: article.id
        assert_response :success
      end
    end
  end
end
