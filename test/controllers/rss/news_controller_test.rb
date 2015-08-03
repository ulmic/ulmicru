require 'test_helper'

class Rss::NewsControllerTest < ActionController::TestCase
  setup do
    @news = create :news
    create :article, :contacts
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
