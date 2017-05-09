require 'test_helper'

class Web::WelcomeControllerTest < ActionController::TestCase
  test 'should get index' do
    10.times do
      get :index
      assert_response :success, @response.body
    end
  end

  test 'should get index with auth' do
    sign_in create :user
    get :index
    assert_response :success, @response.body
  end

  test 'should get index 100 times' do
    #100.times do |i|
      time = Time.now
      get :index
      duration = Time.now - time
      assert duration < 1.second, duration
      assert_response :success, @response.body
    #  print "#{i} of 100\r"
    #end
  end

  test 'should get index with authorized user' do
    user = create :user
    sign_in user
    100.times do
      get :index
      assert_response :success, @response.body
    end
  end

  test 'should get index with authorize member' do
    member = create :member
    sign_in member
    100.times do
      get :index
      assert_response :success, @response.body
    end
  end

  test 'should get index with authorize admin' do
    admin = create :admin
    sign_in admin
    100.times do
      get :index
      assert_response :success, @response.body
    end
  end
end
