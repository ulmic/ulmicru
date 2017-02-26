require 'test_helper'

class TagOnNewsTest < ActionController::TestCase
  test 'check tags on news' do
    if ENV['DB'] == 'prod'
      news_ids = News.published.map do |news|
        news.id if news.tags.active.empty?
      end.compact
      assert news_ids.empty?, "#{news_ids.count} records without tags #{news_ids}"
    end
  end
end
