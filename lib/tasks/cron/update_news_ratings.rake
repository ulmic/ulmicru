namespace :news do
  desc 'Update news rating'
  task update_rating: :environment do
    count = News.published.count
    max_round = News::Rating.maximum(:round)&.+(1) || 0
    News.popular.each_with_index do |news, index|
      news.ratings.create! rating: index + 1, views_count: news.page_views.count, round: max_round
      print "#{index} of #{count}\r"
    end
  end
end
