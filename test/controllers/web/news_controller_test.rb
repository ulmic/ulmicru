require 'test_helper'

class Web::NewsControllerTest < ActionController::TestCase
  setup do
    create :member
    @news = create :news, state: :confirmed, published_at: DateTime.now - 1.day
    create :article, :contacts
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @news
    assert_response :success, @response.body
  end

  test 'should get show of unpublished news' do
    @news.published_at = DateTime.now + 1.week
    @news.save
    5.times { create :tag, :new_target }
    get :show, id: @news
    assert_response :redirect, @response.body
  end
end
