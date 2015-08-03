FactoryGirl.define do
  factory :article do
    title       { generate :string }
    body        { generate :string }
    view        nil
    category_id { Category.first ? Category.first.id : 1 }
    association :user
    user_id     { User.last ? User.last.id : 1 }

    trait :contacts do
      title 'Контакты'
      association :category, :contacts
    end
  end
end
