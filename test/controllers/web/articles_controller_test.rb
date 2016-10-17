require 'test_helper'

class Web::ArticlesControllerTest < ActionController::TestCase
  setup do
    @category = create :category
    @article = create :article, access: :all
    create :article, :contacts
  end

  test "should get show" do
    get :show, id: @article
    assert_response :success, @response.body
  end
end
