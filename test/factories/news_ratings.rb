FactoryGirl.define do
  factory :news_rating, :class => 'News::Rating' do
    news_id 1
rating 1
views_count 1
  end

end
