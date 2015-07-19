FactoryGirl.define do
  factory :feedback do
    user_id { User.last ? User.last.id : 1 }
    url { generate :url }
    text { generate :string }
  end
end
