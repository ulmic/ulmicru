namespace :news do
  desc 'Update news rating'
  task update_views_count: :environment do
    count = News.count
    News.order(id: :desc).find_each.with_index do |news, index|
      news.update_attributes! views: news.page_views.count
      print "#{index} of #{count}\r"
    end
    "News updated!"
  end
end
