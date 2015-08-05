require 'test_helper'

class Rss::Yandex::NewsControllerTest < ActionController::TestCase
  setup do
    @news = create :news
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
