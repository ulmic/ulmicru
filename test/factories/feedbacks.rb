FactoryGirl.define do
  factory :feedback do
    user_id { User.last ? User.last.id : create(:user).id }
    url { generate :url }
    text { generate :string }
  end
end
