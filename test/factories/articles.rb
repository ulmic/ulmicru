FactoryGirl.define do
  factory :article do
    title       { generate :string }
    body        { generate :string }
    view        nil
    category_id { Category.first.id }
    association :user
    user_id     { User.last ? User.last.id : 1 }
  end
end
