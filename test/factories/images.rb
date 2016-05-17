FactoryGirl.define do
  factory :image do
    file
    date { DateTime.now }
    author_id { User.last ? User.last.id : create(:user) }
    author_name { generate :human_name }
    slug { generate :string }
    image_type { Image.image_type.values.sample }
  end
end
