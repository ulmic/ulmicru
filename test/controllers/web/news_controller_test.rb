require 'test_helper'

class Web::NewsControllerTest < ActionController::TestCase
  setup do
    create :member
    @news = create :news, state: :confirmed, published_at: DateTime.now - 1.day
    @time_quantum = 1.5.seconds
  end

  test 'should get show' do
    get :show, id: @news
    assert_response :success, @response.body
  end

  test 'should get show all published news with time' do
    if ENV['DB'] == 'prod'
      count = News.published.count
      News.published.each_with_index do |news, index|
        time = Time.now
        get :show, id: news.id
        duration = Time.now - time
        assert duration < @time_quantum, "#{duration} secs, News id #{news.id}"
        print "#{index} of #{count}\r"
      end
    end
  end

  test 'should get show all unpublished news with time' do
    if ENV['DB'] == 'prod'
      count = News.unpublished.count
      News.unpublished.find_each.with_index do |news, index|
        time = Time.now
        get :show, id: news.id
        duration = Time.now - time
        assert duration < @time_quantum, "#{duration} secs, News id #{news.id}"
        print "#{index} of #{count}\r"
      end
    end
  end

  if ENV['DB'] == 'prod'
    count = News.published.count
    News.published.each_with_index do |news, index|
      test "should get show all published news #{news.id}" do
        get :show, id: news.id
        assert_response :success, news.id
        print "#{index} of #{count}\r"
      end
    end
    count = News.unpublished.count
    News.unpublished.find_each.with_index do |news, index|
      test "should get show all unpublished news #{news.id}" do
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
