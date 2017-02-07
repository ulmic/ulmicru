require 'test_helper'

class Web::NewsControllerTest < ActionController::TestCase
  setup do
    create :member
    @news = create :news, state: :confirmed, published_at: DateTime.now - 1.day
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @news
    assert_response :success, @response.body
  end

  test 'should get show all news' do
    if ENV['DB'] == 'prod'
      count = News.published.count
      News.published.find_each.with_index do |news, index|
        get :show, id: news.id
        assert_response :success, news.id
        print "#{index} of #{count}\r"
      end
      count = News.not_published.count
      News.not_published.find_each.with_index do |news, index|
        get :show, id: news.id
        assert_response :redirect, news.id
        print "#{index} of #{count}\r"
      end
    end
  end

  test 'should get show of unpublished news' do
    @news.published_at = DateTime.now + 1.week
    @news.save
    get :show, id: @news
    assert_response :redirect, @response.body
  end
end
