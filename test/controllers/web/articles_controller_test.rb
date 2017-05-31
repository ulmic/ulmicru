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
      count = Article.visible.count
      Article.visible.find_each.with_index do |article, index|
        print "#{index} of #{count}\r"
        get :show, id: article.id
        assert_response :success, article.id
      end
    end
  end
end
