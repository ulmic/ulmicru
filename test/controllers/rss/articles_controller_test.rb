require 'test_helper'

class Rss::ArticlesControllerTest < ActionController::TestCase
  setup do
    create :user
    @article = create :article
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
