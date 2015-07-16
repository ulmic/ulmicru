require 'test_helper'

class Rss::ContentControllerTest < ActionController::TestCase
  setup do
    create :user
    create :member
    create :article
    create :news
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end
end
