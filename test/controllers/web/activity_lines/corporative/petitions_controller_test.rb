require 'test_helper'

class Web::ActivityLines::Corporative::PetitionsControllerTest < ActionController::TestCase
  setup do
    create :article, :contacts
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    ::ActivityLines::Corporative::Confession.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end
end
